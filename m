Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504836;
	b=RT3MxEh7LrZxytCtoFoslZJ9aSOBLriw4ASgAk81gHX1Yzjyv1aQ4YUyxrskiZTXTsCV
	 0AwD7t+4Sp4mbSTVmC09A0ppjcPzi/P+CPbGrZRPGL86KrwLD1C9+Rz8HPlR6Jr/x5E0w
	 J3saJ0m4P6eDdcb0tOR8lLcsym4+dXYp5NT6f9qCGX9WmL+vUhtpqdOvV5ORYBhpdQP5B
	 8eKsFocQN2lwHfaMcKUeDA6/Faie9BjnzGd5Y7kG8hiSFSOlxemorls8HXZ/JA0k+hfkV
	 KYAYSma5x7a7iNd9Nx3EE3Ex65SM/7pzvq2wSfQa9JXhVAxunvSZj3cd+4CLmOskvXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pvvWiB/HIs4H59vNoAsA0sD6AI7vR7sZ6M7N6d5Xgws=;
	b=J86+Hg57dVPVPPCkF6ThlTiorqTvxIh31JhDR/INEaOhpCfppMFrHoqm3/WuuB1lT3ov
	 LwW/PYYiEuuXo2l0Blt+rZ08pr39TnCwhYGzwJY6wXAOHEGqF4tyxYAsa7QODagGAWIPg
	 M7uUpiJz6XxQn71/AahfbREp6feKYpOyyuHY7pZSAoWVTMEvpT7rloPcMXlcpuDo119uh
	 R9Z1qt5iVYo3iCWI9lpDUO08wUllLw1FW1fcpqpIqzpshsFwX/0GbepYxqKSLodaejv5o
	 dGBjlu/bXbk0IXi0DHtfvFkgv10bFsHIsjuL95gpQlE0RG7+pu36j/R9KdWDwJyZedQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spStT64T;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164160A263F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9164160A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=spStT64T
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so3689824a12.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504835; x=1793109635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pvvWiB/HIs4H59vNoAsA0sD6AI7vR7sZ6M7N6d5Xgws=;
        b=spStT64TSdX9HNwicqMbVM8oRQSavile+EArNF1PJmJM5guZBb5z331MenwaNSGI+h
         Fwx00CGIghbLZ2Kms8oTkCLDQ3G+djkxMGWX1MIbd0ftStBUZaSZQg9rYNYvPmCON4lD
         P9A3oyDZEdeZ/QozuU13RBOh9zXUP8EVrTVnnLrjSV7KyXKpHkb2qqLLC1n/D4zCaqC3
         mY72cQZ2Ll96uqONMO3UEiZawQ4Kdg1JgraQt0Gpd0mdJJnDE/RNrRTSy/aRokPc56Rh
         mcU7nvVCV8BHtum4PuVWw+ANTq5p5e09x9l0PMv7+dLYfHNJ9Zn95sV9a9F9ZfSRm+ns
         d8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504835; x=1793109635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvvWiB/HIs4H59vNoAsA0sD6AI7vR7sZ6M7N6d5Xgws=;
        b=LlvyYUfwvoZKRVESWWyD8FlKebEGa7YgnrraO+lD2M/VCJUlb7/ja+DPjaPp5auata
         XJKkZkz3knST9ZIOUcJe3HW3eUHzngr+ny4Og1243vEH5tG+ToZ9T+JKxoBNb0qbpUxg
         tlmuZAd3bkcXdq0tO8KNeM2VVeXUSviZ8ndDZKrfH7EjkY9jvyScjPptGHlIRwzhkJL8
         fZd8HSpcUShBpcPS3gs6sXsnVDU+T1D+meBIxT0hIej2ZC/eichB0QNfSFUHXTAF+sUG
         lfEF5feaq6bIBGb4xJp89OkrpjE2yfwW9MTGpZw1eCAVbfK080qYpxVvHtW7pDSuxfvO
         Ya6A==
X-Forwarded-Encrypted: i=1; AKwUvBxmJHe9lGLNL/BCeWZpnObEmobHENb6eWG0yPAZ01ZmiRpvpzHoOiuRGYozmEK9+LgHJIIxAyY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyREDmgab1CRGN94j2Oe098/Mwy7rMDYRpCT3esY+OpTo/qp0H
	sfcgdSzA9JfAqgcE6p9N79aSEEQJ5xoh4jazu00TjnxX7aor8bc+qs4r
X-Gm-Gg: AYBFou0Wyr0khCGlCQHbqK68MMB6RSynr4yI4WM0bnvtGP6l0OyNOh7XeKG+6pePdzT
	GyfBEVhplN5yYWdwzjxq5izEGz2rf4bwS1PAzjKiK25s7NmzsWgmNPu3BN+Gdpa2V2q7ZGQHsp+
	k3xdtyesdOqnQ4STTKDGg02kp8rdQQjWlBsGrWAf18h8CwDMq+DYo7j7sD5aD9T01wYCnU3gHmI
	hvloQrFSA1QBnuxBCPci8vGtBkhkfYmmCjnYeUL/QlU+7V954fz7VoJ9Lrzx1yF/XF78zbhEpk0
	tbA3bLykSGdQBLFZKO3n1vyKgxfYFcWqyWgfF6TWvQuIS0ZBapR0+XAWE+Q7y1GqPS4IqBkBKsc
	JiUoBxHvcoQP66iLXcpYD287rmUKtrBZBavnGW8BZaT0PCmgk0FHEXTHVFnE12yfFeoeQ2AZ5QQ
	JsJTnX/yMpFGA/0vC5N4zE0urOs3vMN6cVuP4Ti485nn3e6gnxzE/u3+VTGOe+41/zT4SRIZ37+
	mXvKqx90yRBd61vUvQKj7boT3sHfelzQXXFGGLkMz4Hqapgr7z0mEjkHo9yteG8CWuKoUq5To+R
	pIWObcujrb6oZvXFmcy5kAxPHgySrSH/uUd9ka1cZYA=
X-Received: by 2002:a05:6402:249c:b0:6b3:bca6:b480 with SMTP id 4fb4d7f45d1cf-6b3bca6bacfmr6223968a12.44.1792504834506;
        Tue, 20 Oct 2026 07:00:34 -0700 (PDT)
Received: from Martyna-s-A34.localdomain (ip-80-113-116-3.ip.prioritytelecom.net. [80.113.116.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1c6364sm5431458a12.14.2026.10.20.07.00.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 07:00:34 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: check address length before reading AF_UNSPEC bind address
Date: Tue, 20 Oct 2026 16:00:30 +0200
Message-ID: <20261020140030.92643-1-mike.michalo@gmail.com>
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

bind_map_addr() handles AF_UNSPEC on an IPv4 socket by reading
addr4->sin_addr.s_addr to check for INADDR_ANY. At that point the only
length check done is addrlen >= offsetofend(struct sockaddr, sa_family),
i.e. 2 bytes, while sin_addr sits at offset 4. move_addr_to_kernel()
copies only addrlen bytes into the on-stack sockaddr_storage, so a
bind() with a short AF_UNSPEC address makes AppArmor branch on bytes the
caller never supplied.

Depending on those bytes, a confined task gets -EAFNOSUPPORT instead of
the -EINVAL that inet_bind_sk() returns for the same request. Kernels
built with CONFIG_INIT_STACK_ALL_ZERO read zeroes and happen to behave
correctly.

Check the length first, as inet_bind_sk() does, and as the AF_INET6
case above already does for inet6_bind_sk().

Fixes: 89ac6aa752ec ("apparmor: push inet mediation into profile callbacks, and improve auditing")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
Tested on v7.3 built with CONFIG_INIT_STACK_NONE in QEMU, with a task
confined by a profile allowing all network access, calling bind() on an
AF_INET UDP socket with {.sa_family = AF_UNSPEC} and addrlen 2 and 4
(200 times each, after leaving a non-zero address in the kernel buffer):
unpatched returns -EAFNOSUPPORT every time, patched returns -EINVAL
every time, matching unconfined tasks. Other AF_UNSPEC, AF_INET and
AF_INET6 bind cases behave identically with and without the patch.
---
 security/apparmor/af_inet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/apparmor/af_inet.c b/security/apparmor/af_inet.c
index 516c9016537c..a617f8058634 100644
--- a/security/apparmor/af_inet.c
+++ b/security/apparmor/af_inet.c
@@ -196,6 +196,9 @@ static int bind_map_addr(const struct sock *sk, struct sockaddr *addr,
 		 * AF_UNSPEC if the address is INADDR_ANY
 		 */
 		addr4 = (struct sockaddr_in *)addr;
+		/* Length check from inet_bind_sk() */
+		if (addrlen < sizeof(struct sockaddr_in))
+			return -EINVAL;
 		if (addr4->sin_addr.s_addr != htonl(INADDR_ANY))
 			return -EAFNOSUPPORT;
 		family = AF_INET;
-- 
2.56.0

