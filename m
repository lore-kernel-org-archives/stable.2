Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681971;
	b=q88xPHVu4QVTogIU5/Dt5QTvn1DvpmdP5MrK9jZ2gvF0f69cJYvOAN8witVe8fbI9bfm
	 2nUYBZtMvsf+PygOT7DhY062HXmjGMgh0mh3A4SK0ukcJrF0bsD8e9nwqRjIqu1/NiJSp
	 10zLLqHivqndfdtzhsSr9ctoP2P7t5tFwL6+szYeI0zRmshFiSn1Vs5DK+h7R63gZZS0x
	 35h4ej+/0wnJNeRvKQNZZxPJl5O9JQilxcM8MZ0O95C3dU/PCGgY+lefuX9JxvHhfJnBB
	 mQJYinQSlsPI7JNs1+damkHhLa3ZYCU1CjQTFrKVbFXnGFEYn/25MY7xzofTMmY1qhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NZairbP0b4YAQlRihucfuuFbYADO0pre/pVKDVxPxbk=;
	b=f7UzC/kI3rdJx0TBmj/Hpj6Zf7vhCLWYmGgRG+BxpYkGnbKMTGQWcGzz7oJX8wDa32WW
	 20j7YQ68OW5dbcDecD+1krN7zjbYv62COLXGsZUXEDzlGXXitTSaShjYjdLX94p2uBOtL
	 oUrBujxFZaCTfxCW0CoqWcVikAMRzCJAoK3N5AujO1IDT5wWWPI/WaAKQNuhx3UOJPxXP
	 MwO4lkibGUbbBsdNI4MMg7S7JZxGPQkfdSaumIqzhvCKszkLK+3kRQBBNnQ/W5CZla3ye
	 sBPSY4RBzFYk5QmpxXAHMfhXLZUL9LGAwU5C2P0c5PjJSjT3q8Zzq/PH1JrqlvxFmMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrLM7YPO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA1606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrLM7YPO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554021F000C4;
	Sat, 14 Nov 2026 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681970;
	bh=NZairbP0b4YAQlRihucfuuFbYADO0pre/pVKDVxPxbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XrLM7YPOGUJBGY3Sx/TB4LjOdoBG2UXSzX42B8xNPqx3xhlDCKF5GCp1MJwL+C/fS
	 sXAmyE+oJK8ts2hxEIC5wSN6FV2+vGdTVTV/cPUyiij/aS7bDQCJhqKL44fdiTUhxg
	 raMav37302AI6x0yLWZowjdu+t1EpKVZwMSCnAJwjhBmwhq7BvzNVU4pv/wdIWStah
	 pmkV+j1g+9WIbrclAOZ2kYNO/JstfXlyJvZM0YZ6Hy9xNuhyH06xykNpQZPQj2d1KL
	 pISKAWJ3Vbqe3yk2FKoKBjFMJc0XKcNrxndjZylpKFWJ7Mo2GdswSTxVfPx73h6bPI
	 I4oNIP2gB3Ozg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] srcu: Add NUM_ACTIVE_SRCU_POLL_OLDSTATE
Date: Sat, 14 Nov 2026 13:46:08 -0500
Message-ID: <20261114184544.402778-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201443-failed-6.6-d06917d0ba22@kernel.org>
References: <20261109201443-failed-6.6-d06917d0ba22@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 395e73bd8d35fa9b8505e44f63a2a10abde09cce ]

This commit adds NUM_ACTIVE_SRCU_POLL_OLDSTATE, which gives the maximum
number of distinct return values from get_state_synchronize_rcu()
that can, at a given point in time, correspond to not-completed SRCU
grace periods.

Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Closes: https://lore.kernel.org/all/irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Stable-dep-of: d06917d0ba22 ("srcu: Add list_splice_init_srcu()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/srcu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa5..f664cba7a80c2 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -61,6 +61,10 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
+// Maximum number of unsigned long values corresponding to
+// not-yet-completed SRCU grace periods.
+#define NUM_ACTIVE_SRCU_POLL_OLDSTATE 2
+
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
-- 
2.53.0

