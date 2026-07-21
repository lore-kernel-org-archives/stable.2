Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8A3C988E;
	Tue, 21 Jul 2026 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625308; cv=none; b=TfJmaqqNTZSd9GqCMteHIEgW1jF0OlD97rsA3BG53ILhv51EDwyXBpZud3y/sPXeMGpXqZTBZzoDsv8OCf2ky4Ek6OxOC94cazo/28Tz6IhzY7MSq8Q0UNCbpsN6BdHv9bShnC+koE2yu1FC2KOtcuZzMVKG5Ea90Sm7k/haTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625308; c=relaxed/simple;
	bh=0jKVY9limujZHMkQCFkSfDZdQbVgnY/UgkzQQ+cqdkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nhvU6Pjif89QI+iL1xeQYa8EUrCkonzHVCYiQMbvE8UUsZeHRWUVmtRvjMm5jmxQOJbeO+9jS1TmYdjm2AhrsmrP5FBP3aLHDlB6dGGWa003Hnl4k6oOqw3GT9gvrycXpBeW9cIkuXR2yqnbvD5vLQ18MwPCNvhlUoqAQp1eHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MQfFiaXq; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MQfFiaXq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=t54cSLuFqe9/2RaZr5X/abo+OxpDLKy3hDgJtDRfM9c=; b=MQfFiaXq3Ppjak/55OZJQsidTA
	1B8jtweIT4VQlVkD1b4fVMjTGEbwqxCx50jYsxkAhMUSc+LkvHNSsMKxtLKVLEFVY1EsL38577Prg
	HpkwLsezc3ngU8L/jFZPDSpPMh1x+9TywBuRUrfkViWgRu91gJo/1IABpLqdyUAXx7iJwveYHZxFZ
	jIRmey+RAy0P/LM9hgzpdmVTYqVmjPlAmpA+ev2VKGLaSDsWUxddgGs3rGs27iGwyrpc+nliRoq7c
	lapL5iTyIoQBF1erMD6Hu/b+kK8OCtZsjmM07qccRtBJLfsv7Qt2ioyFok9hfL8bKCq3ZMw+XEHNz
	Vl1Hc77Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wm6JS-0026F7-2B;
	Tue, 21 Jul 2026 08:58:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 21 Jul 2026 01:58:45 -0700
Subject: [PATCH net] phonet: pep: fix use-after-free in pep_get_sb()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-phonet_get_sb_uaf-v1-1-95fd7881cc4e@debian.org>
X-B4-Tracking: v=1; b=H4sIAMQ0X2oC/x3MUQqDMBQEwKs89ttAGqzWXKWUYM2q7ydKkpaCe
 Hehc4A5UJiVBV4OZH616Jbg5dYIpnVMC41GeIGzrrO9s2Zft8QaFtZQ3uEzzubRt3cOcYidm9A
 I9sxZf//zicSK13leOoIR4mgAAAA=
X-Change-ID: 20260720-phonet_get_sb_uaf-8745e9d9d62c
To: Remi Denis-Courmont <courmisch@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?R=C3=A9mi_Denis-Courmont?= <remi.denis-courmont@nokia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=leitao@debian.org;
 h=from:subject:message-id; bh=0jKVY9limujZHMkQCFkSfDZdQbVgnY/UgkzQQ+cqdkA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXzTKPg46uP0aCv5ENZYeU2wzqwFE+INBz/PuB
 PaIkcmZrR2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal80ygAKCRA1o5Of/Hh3
 bc7CD/92+wp8ekbS2cMN5n+xrSC6UP/z0a58HzQo5lG3h8i1lJcO0ihZwZojLNwaRPio5hzItmx
 HextEUuMHNfim9FV64zNbrzVfyDym3suxrjznJHJ83MZ+AZ+1J5vzvlVbFfKswOQGjbonreh+no
 x0AA/uchSc/Ml5rCiXBJWcdbaZ/5/L/N+0NuaZvb/lZujLdZFRJc7aLOowFbUMlJtK0+mg8Vhyn
 8q6SUttuyrvmAtA9eLcYjUwx91cMtlCr6lfhvDwGHn2G8QQHjFKQsyz+q2dL+XoTcol6nEzGsJd
 t01XvROAz+YD5gy/pqK3lEYyvoi+hxv154mPkjIo30jRnXQSa5fPiKDcvpgOPBVkLrgKcJNHAjj
 Y/GrSPYsRyzHmJ4kmLfCK159jQacP1ldATkB7UTIXB6AVFWfFzHBKTVypysmdx4LZ1WcneceOsB
 9Kv3t+vOYMRyN63zpexAyZlDyA7CtypxGLTiXnqRWkBilh2xTt/M9bVqeTjZNNamSym0Uz89J5i
 2xryjJsZfFhgIQqMH6grcux+iBpjf0QV0ryoXU99xDPxJnyYrLwYZcIU+y81vgCFbQ6LfJ8F0e+
 4qRx47VI66Nd3M7hJpq//OZF6t3sZ88Szh+utQXhaPGCSMpY4MkYiRx59L8JpOpnAiXECGJ+VWo
 zhgijZNU3lM3EhA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

pep_get_sb() doesn't consider that pskb_may_pull() might have relocated
the skb data, and continue to access the older pointer, causing UAF.

Reproduced under KASAN:

  BUG: KASAN: slab-use-after-free in pep_get_sb+0x234/0x3b0
  Read of size 1 at addr ff11000105510f50 by task repro/157
   pep_get_sb+0x234/0x3b0
   pipe_handler_do_rcv+0x5f7/0xa10
   pep_do_rcv+0x203/0x410
   __sk_receive_skb+0x471/0x4a0
   phonet_rcv+0x5b3/0x6c0
   __netif_receive_skb+0xcc/0x1d0

Refetch the header with skb_header_pointer() after pskb_may_pull(), so
the possibly stale pointer is no longer dereferenced. There are better
ways to solve this, but, this is the less instrusive one.

Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
This showed up in sashiko report, when I've sent my other patchset
https://lore.kernel.org/all/20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org/
---
 net/phonet/pep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 7069271393933..31b29e3ca7bc6 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -55,6 +55,8 @@ static unsigned char *pep_get_sb(struct sk_buff *skb, u8 *ptype, u8 *plen,
 	ph = skb_header_pointer(skb, 0, 2, &h);
 	if (ph == NULL || ph->sb_len < 2 || !pskb_may_pull(skb, ph->sb_len))
 		return NULL;
+	/* pskb_may_pull() may have reallocated the head; refetch ph. */
+	ph = skb_header_pointer(skb, 0, 2, &h);
 	ph->sb_len -= 2;
 	*ptype = ph->sb_type;
 	*plen = ph->sb_len;

---
base-commit: 1c975de3343cdef506f2eecc833cc1f14b0401c4
change-id: 20260720-phonet_get_sb_uaf-8745e9d9d62c

Best regards,
--  
Breno Leitao <leitao@debian.org>

