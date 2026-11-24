Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490992;
	b=F4UI+4LfStsuuu8rdWSHMgCSe6N/+GGJsoQGFLN/ClRNr2zx3kYiUk0L47I4hooCt3Nt
	 U3bmrcZY+7t1ULJPbs46xs+2+HF1sMIZSZb38xkKhxbJWD9oeIdAcpq9Xl10kVfJsFeJx
	 9lrifx4gKiYeAKFiVJv2XIc4iV6n/cvMuM1VT8+1osKik21oPVgACXA9+Qw8mVFsz/JjH
	 bsUAFvdt3N0cUIg13qyMvjE/6ox/11Jz6kwo6T2ZIoV+l9hOCZHECnnGNSbARtiO7zGJW
	 kUsPyympUiS5ksuu6KgYtG7h3zaqYRYi8kx1H5+MYUQkudLbKmxhfWMQ8sORNajYq1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e5Opmlw6W+7IY9g9unaFxu16R4gE9zSxgAoE/RUOQJw=;
	b=19RRXZUc5tgRIZVUjwhrL5uN6jGsSIbzSMaGTapsJ8DQMeaWrh6p7fE+TzbAoeO4YTBf
	 8Ek475ZxajvEQwgdxuhrSmzyxrF9fYw3iuNxoskGl/jRqZLGuyVG6YwGEUGg5lGmWKBz/
	 YuYn3QLjzJXTmGdTnCkNGigEHcYuZx7m/nly0NuRDE+5kcYIsxcqCG/EI1eldjAcXaQUq
	 et+gR0mbYAFSr7sq1NsEGKG0GmEMwhSIVezRa0z2FhXzOcwpUOkzlq1c97IYQujHniHzJ
	 byfu88GgG0a37r817FaGbzZybwvltv0NIsiUO/5jxjrmsuUnHWn3ztWTTT/U8s3RW2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=cyVEFZrL;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA58606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA58606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=cyVEFZrL
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2f05b465cd1so18637135ad.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1795490991; x=1796095791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5Opmlw6W+7IY9g9unaFxu16R4gE9zSxgAoE/RUOQJw=;
        b=cyVEFZrLqgJ70eSeLwYbJxeW1eLKC/b8ZFkHJAdgnDtJFTVOyziG9CfUFViuDFd1K5
         K19BbuIDmf+DQepi6NYJgahfL15NBziUZL/2Wm8WcNshMG2e3Eoio93BPosykeph6NMF
         1Q8CQn3L13ByWVExtc/46sEKeasUK1GHeZsfTPHGUTWWpKYcbL0t//rQurEsCv6Jvzfz
         A20Rvygg/F0n7QIF2c/CLIlnLpg7sePiLWdqqF96lTzJdxcTizbQgEuml9W2FRC5weuR
         KfXQ61n0Y5TT4rjCz3IiifOxSQF70MdBL1r3Hw2R8oVUZnY0roqF30ZO3mQtIPhd87o+
         c0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490991; x=1796095791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5Opmlw6W+7IY9g9unaFxu16R4gE9zSxgAoE/RUOQJw=;
        b=Msh7omZBMggCUI9XFTOwWw2koRWq2vr+D/yR8fB6lVD04WXPR9L1ugyG1GCkTz2yg6
         vrB7QEjl8xP+fToolGdXYwl7jqmsWn8gnUDDWp7qyFgh56A7K/2+E7SmSW4qrDlc1D+P
         QD3PmRaU/TWWdayC1bMICCpIsNapHOyYOsCNCE7VaCVLv0lDWpfa4KZS7Xoheh/YyZjV
         SjqVIHpfQFkhjpAgA7oZZSXYa921NzwBrwAXAplg4XeJ5OTR+oyGGGiUxsXUn9dcajRz
         on4kghrqCyk964L2dRkAyZYFWWstomHAFo2pMd203ve0zzHLS5iKN/DBJrGB7NfIr/pO
         h1hg==
X-Forwarded-Encrypted: i=1; AL+hErF6nGmU+RwNI7yp2lqj9tzQbkHVTWcsT9KDcShj1muP1Uw9OJzXVnqtdiKLmNuRS22xN9yfgiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yd+BNlxLgDIaL9W5ReH17mF3LuPorJPGszOgz05rAr8vq3+VH
	JY5LFUvHvrqusqGHRv1MxMeS+l1piJJvCVA8vxwPdRu8xZZSEnw2Pr85JTf57D4uLyEewluNHNb
	/vzrlDz9qUxAb0+xEZ2f74/XxTHb83K0UQ4g5ykEMzbGjKX6lGo8C
X-Gm-Gg: AZFdTZfLuUw34pgJ1Ld5rPWVLYb9eoANxKU4zmQt+gCALFjVLTMoGNFoi2vEnP0TONk
	6ootCNuynN7JEwY2BzT9WIN4qb1Q3eb0FCvOx2z7+H27UwZURtpgmyczRQY0MmWYKoX276KZ1Bu
	HguN874Te+HtXC2KzYcgwssPofOUTydgHm8RXAvdxL7zgGUBehygSBPSVK+OQ/iYdNQFRO54K+Y
	3qApQ4Pt1L5+X3ME6dT2NaUYpemQADSiNAEK+6i5RC91Xoz2klxHbyUX16txSBQ8+rbHJWcRttW
	hjwfMlft0HNrcgP466VfUUlMUV3L1TrSraYF8rZ33KvhG1QQmb93/siimDCC23g0qKnoE2YwyjD
	QXM/m/s70OecSVBHna0mI5/fcBWA=
X-Received: by 2002:a17:90b:17d1:b0:3a8:a98c:ea07 with SMTP id 98e67ed59e1d1-3b41c8e1735mr11583721a91.13.1795490991106;
        Mon, 23 Nov 2026 19:29:51 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41cfc74bcsm4445939a91.0.2026.11.23.19.29.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 19:29:51 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ipsec] xfrm/compat: pass on the translated length of a socket policy
Date: Mon, 23 Nov 2026 19:29:46 -0800
Message-ID: <5249741d-fa84-4d54-bf77-45f48dbbb169@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
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

xfrm_user_policy() compiles a 32-bit task's translated socket policy
with the untranslated length, 4 bytes short, so the policy loses its
last template: an ESP-required socket policy then sends in clear
text. Have the translator return the translated length.

Made with an AI coding assistant, reviewed by the submitter.

Fixes: 96392ee5a13b ("xfrm/compat: Translate 32-bit user_policy from sockptr")
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Tereshchenko <opensource@andrii.net>
---
The 64-bit struct xfrm_userpolicy_info has 4 bytes of tail padding
that the 32-bit one lacks (168 and 164 bytes on x86-64), and
xfrm_compile_policy() counts the templates as (len - sizeof(*p)) /
sizeof(*ut). With the 32-bit length one template counts as none, so a
32-bit program's ESP-required socket policy requires nothing: its
datagrams leave in clear text, with no SA and no acquire. For the same
reason a policy without templates, which IKE daemons set on their own
sockets, is refused.

The BUILD_BUG_ON()s check what the translator's memcpy()s rely on:
4 = sizeof(struct xfrm_userpolicy_info) -
sizeof(struct compat_xfrm_userpolicy_info), the fields before the
padding at the same offsets in both layouts, and templates that need
no 8-byte alignment.

Found with an AI coding assistant. It reproduces on an unmodified
kernel (ipsec master), without kernel changes or fault injection, and
no longer with this change. Tested with the reproducer, a selftest,
two boots each way, and with the xfrm_policy and xfrm_state
selftests. The reproducer is available on request; the selftest
follows once stable has the fix.

 include/net/xfrm.h     |  2 +-
 net/xfrm/xfrm_compat.c | 18 ++++++++++++++----
 net/xfrm/xfrm_state.c  |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 445223a8dc6f1..455b9f986ea5b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2331,7 +2331,7 @@ struct xfrm_translator {
 			struct netlink_ext_ack *extack);
 
 	/* Translate 32-bit user_policy from sockptr */
-	int (*xlate_user_policy_sockptr)(u8 **pdata32, int optlen);
+	int (*xlate_user_policy_sockptr)(u8 **pdata32, int *optlen);
 
 	struct module *owner;
 };
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 670e3512fc090..af5cb36d691ea 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -642,16 +642,25 @@ static struct nlmsghdr *xfrm_user_rcv_msg_compat(const struct nlmsghdr *h32,
 	return h64;
 }
 
-static int xfrm_user_policy_compat(u8 **pdata32, int optlen)
+static int xfrm_user_policy_compat(u8 **pdata32, int *optlen)
 {
 	struct compat_xfrm_userpolicy_info *p = (void *)*pdata32;
 	u8 *src_templates, *dst_templates;
 	u8 *data64;
 
-	if (optlen < sizeof(*p))
+	/* The 64-bit layout only adds tail padding, and the templates
+	 * after it are the same in both layouts.
+	 */
+	BUILD_BUG_ON(sizeof(struct xfrm_userpolicy_info) -
+		     sizeof(struct compat_xfrm_userpolicy_info) != 4);
+	BUILD_BUG_ON(offsetof(struct xfrm_userpolicy_info, share) !=
+		     offsetof(struct compat_xfrm_userpolicy_info, share));
+	BUILD_BUG_ON(__alignof__(struct xfrm_user_tmpl) > 4);
+
+	if (*optlen < sizeof(*p))
 		return -EINVAL;
 
-	data64 = kmalloc_track_caller(optlen + 4, GFP_USER | __GFP_NOWARN);
+	data64 = kmalloc_track_caller(*optlen + 4, GFP_USER | __GFP_NOWARN);
 	if (!data64)
 		return -ENOMEM;
 
@@ -660,10 +669,11 @@ static int xfrm_user_policy_compat(u8 **pdata32, int optlen)
 
 	src_templates = *pdata32 + sizeof(*p);
 	dst_templates = data64 + sizeof(*p) + 4;
-	memcpy(dst_templates, src_templates, optlen - sizeof(*p));
+	memcpy(dst_templates, src_templates, *optlen - sizeof(*p));
 
 	kfree(*pdata32);
 	*pdata32 = data64;
+	*optlen += 4;
 	return 0;
 }
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f4a4ddaeb9b37..eb984ed118884 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3115,7 +3115,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 			return -EOPNOTSUPP;
 		}
 
-		err = xtr->xlate_user_policy_sockptr(&data, optlen);
+		err = xtr->xlate_user_policy_sockptr(&data, &optlen);
 		xfrm_put_translator(xtr);
 		if (err) {
 			kfree(data);

base-commit: b88c75488ecc768acadb14e980bbfa087b1dbf38
-- 
2.53.0

