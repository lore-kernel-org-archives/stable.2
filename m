Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF23546C1
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581770; cv=none; b=nOY0W2+cgwhvjQnLQFTa/GpEeTRpjJPNECXYwATNiHxImNqnlXGXjnPdevXo9x7svpkxsilDEwpXSAUsX3kxpg35/hbq19Z+v3+JyThUk3+jxKyGeprEZsxDrOebLP8QqNZbBfQ4Nd1AJtkiFppurgAgyUUIXnA7baJF76WVqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581770; c=relaxed/simple;
	bh=4f5mET2qHdJWf59mHInnxbIAmJYHh0xnDdwx/k3aKx8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q1G8AKUdpMjnpgRzBeaeMO/uTaQUkEEIaDgSOexVJhw6JvRsRYGkUjebtUPzG1JSPz21dDQx5rikBa9Y1KRUDpm+wD1C4DMv3/kE3Oh06SkXl8EvFMAGRCQlLp8T08qkmE4h2Ao898NQPiDtSh4T2gqmZ7WniKKealDbB7pNTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mubW4IlD; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mubW4IlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790581761; x=1790840961;
	bh=4f5mET2qHdJWf59mHInnxbIAmJYHh0xnDdwx/k3aKx8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mubW4IlDVwaGEkrgZ49GJxu3tPDG2u9NXJhXMraJtGJSVwM1I9+ai8vnL+dY8ZW6i
	 VzKhoUs8zdKfIWasPuisgJLlo0AkfGFXWsC40Ez+RJLMvz3ijdRqOtCWp/QDQvwASE
	 VzuNACbDy7aogf4QVf1ZVBPQHM/SApj+Ij+wMc0LyJ3t4zJ84UUQkTDTvxBTU+p8Yq
	 KaY6KPSPOvvobzfIHQA1sDOhbT4WK1bc8N6OHJvVYPDn0qFSGJ6Sb65BCdPgBLf7DP
	 rk+EgFgl1QZh/NMHdzxCQLdpcmAiwZZnXCDJi2eiNpumM2arJzZ+/FFph6JzHTTrD4
	 OIhcf4twn+wpA==
Date: Mon, 28 Sep 2026 07:49:15 +0000
To: stable@vger.kernel.org
From: clkernel@pm.me
Cc: linux-mm@vger.kernel.org, axboe@kernel.dk, syzkaller-bugs@googlegroups.com
Subject: [PATCH] mm/filemap: queue non-exclusive folio waiters ahead of exclusive
Message-ID: <210c652d-f52b-4742-bc35-335394e3f99f@pm.me>
Feedback-ID: 224698563:user:proton
X-Pm-Message-ID: d68783683301182b3ccd953825ae63a8294c981b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A folio waiter queued behind an exclusive folio_lock() waiter on the=20
same folio is skipped by folio_wake_bit()'s nr_exclusive=3D1 walk, so a=20
shared/DROP sleeper (folio_put_wait_locked from do_read_cache_folio)=20
never receives WQ_FLAG_WOKEN even though its wake ran: readers hang=20
D-state in folio_wait_bit_common, fresh reads of the same page answer=20
instantly, and the sleeper wakes only with each later lock/unlock of=20
that address, one page at a time. Numbers from a queue-walk instrument:=20
363 skipped waiters per 10-minute run before the change, 0 after.

https://lore.kernel.org/all/6a4763e3.9dc7bc9d.3d5df4.0007.GAE@google.com/T/

The same change cherry-picks clean onto v7.2.6 (mm/filemap.o builds). It=20
only reorders the enqueue side: non-exclusive waiters use wait.h's=20
default head-side insert, exclusive folio_lock waiters keep the tail, so=20
wake-one fairness for lockers is unchanged.

---
mm/filemap.c | 16 +++++++++++++---
1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d721986d5f46..48994aa81320 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1294,8 +1294,18 @@ static inline int folio_wait_bit_common(struct=20
folio *folio, int bit_nr,
*/
spin_lock_irq(&q->lock);
folio_set_waiters(folio);
- if (!folio_trylock_flag(folio, bit_nr, wait))
- __add_wait_queue_entry_tail(q, wait);
+ if (!folio_trylock_flag(folio, bit_nr, wait)) {
+ /*
+ * A non-exclusive (shared/DROP) waiter must queue ahead of
+ * exclusive folio_lock waiters: the nr_exclusive=3D1 wake walk
+ * stops at the first exclusive match, so a non-exclusive
+ * waiter behind one is never visited and never woken.
+ */
+ if (behavior =3D=3D EXCLUSIVE)
+ __add_wait_queue_entry_tail(q, wait);
+ else
+ __add_wait_queue(q, wait);
+ }
spin_unlock_irq(&q->lock);
/*
@@ -1429,7 +1439,7 @@ void softleaf_entry_wait_on_locked(softleaf_t=20
entry, spinlock_t *ptl)
spin_lock_irq(&q->lock);
folio_set_waiters(folio);
if (!folio_trylock_flag(folio, PG_locked, wait))
- __add_wait_queue_entry_tail(q, wait);
+ __add_wait_queue(q, wait);
spin_unlock_irq(&q->lock);
/*

