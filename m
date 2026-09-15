Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB040A927
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488251; cv=none; b=phT4J8iumwtvIAkuoTUWN8KcFMRR9VuI1gcHANUcej/j5uFzMupafWBEfMLs6RBs7rEB+5tY+1z0sUVG0w6jtBHUZeLqqqz9LkNtDO1gutRRDbTnJqL1AwORhXnoBp11l+Jro1ifJoR7+aksaLVQBBguYv3OtUxuFz04lMTjhvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488251; c=relaxed/simple;
	bh=lA636VS67hdrjx+PMhYpGgpYnpbYMhQFiYdOHjN8K/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1ZSQH8ePtv7Fgur/mU9ipGepQmA5EnPmZOR6JEMa4hONb1nQN3B1I+WZ7YrPYCPicdiPJaQ5xoTThZc9mMWgLoZtDPLBQLJlfF57mWdtnnksHH9ULNG5iPXsI2APGxOaeq/o2BpOq84UEzGTrWfhtjoz9lQiEQM4Wv5lYeWkmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKu0cNzw; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKu0cNzw"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e2ff27eso2696164e0c.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488249; x=1790093049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=el3jo+f6tEFLjvK3L/xYGk89Xvgt7/7dA3tjV60XJTA=;
        b=LKu0cNzwtRgz98Qutp+MCpe3bYH/0teD9AMpMFltYHEhF4HcEATg8I+a61Wtw3HG+m
         1Yf3QEjEz/8hOa1G/XZQPt1xMqbxuRYAnO0t7J7Q+lNpJySj6JqgXdjMXW5ujAQJGBcR
         JG9EnysDX2M2Bi2T2W6Bpxn7bxnOOgByYriOwlQn/C2k1lJYuj8O4UUxFPmGZi/5FCg/
         FIFBHDpbTC5tFxVORmhirXX4EfVAX0I66fBY8HDZra68Age96S+xnyeM41th/zIX6Fky
         7fQOpaR9xdUmrHM4XlUxc5CGblyDBJe57YR9bjJfVq5Tjvqh8Ig5KwS7bKJwPY1rpxkx
         D85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488249; x=1790093049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=el3jo+f6tEFLjvK3L/xYGk89Xvgt7/7dA3tjV60XJTA=;
        b=KFeoVrchu9km80XUZnp3DwTs7QQ8+vNh2unye9ablZFnTa5xvVb3RMmiDBP4wTyNM2
         ZexgoSQOuUyJNQpJem47T+0C68TSjzpG8xl4v73lJKYLQVhzsAY1v56juLCGWrgmfOBh
         LYxeCfaco/kc3RhEiaPgWzg/cSu4svDP71EITu7Z5ZIM9kveARTqrWTEFpfKr+Sr8ZL1
         MT1s27nhEaYUG7cB8xPGTJu9xU9nMfn42pp3YUP2dPWDBe4Ismcfty9bIKxaV6C0OXtj
         p3A3q8n5Or+l2QNDWQWzoiXN4irqI08DBt7sBo3dYB1ePWH1N87ttvkg0TJuv3licqb6
         Gpyg==
X-Forwarded-Encrypted: i=1; AKwUvBwXL4NtvCUraZ7az3xO1sVAb8byMqt0wdKIq2X/hgZwv+Fe9xGgZh46PvFgn+tWHt/ukMr+0lo=@vger.kernel.org
X-Gm-Message-State: AFuF++keo0fuo5LPibbZpgF69vzbhuiSSyTnJ13acssJAYruwWdtSMub
	oald3UvSkbMm1v91rdJF+2BqOUTdgmJVgocDxmL257CyhsjBwJEpA7Zd
X-Gm-Gg: AYBFou3gfsRcWnA/ZE/0Wl8mXKUSKZNORfQP+gMCWwdHzKZHW9ldMsr6wepyYkeQAbE
	TmPa0ddXj4L+w3wnoCrLy0oJaZrP90HRccqkXRu5ZjV/0lR3hTMzBfoebXHMYvXkl0d40N5Z9ln
	3wIbJEmWbGPztxi7/Hu1KWdOco5e76IENnb7JQDQYerduM5bWQx5VKI6gh9nOMQVqCVfXp546eu
	7zrofnLtB1q3jYRI0W0CSHNnsqTPAhMy+v6T0Li+c1o7Jiye05XJgsDd0FxUVS8ma6iDmpv5knc
	bPya5gkMeRBem4pfgaoN4XJkvNl7iZzIxE5IvTZwSdMCAS4S5comVVvry/79ftsLc1dwU1U4Kax
	udwilecSMuM9eayrVZZF/ivnUfttfCF+4THMOEKFBPiiEfhCqQn7EC1I2J5ZrgIzOT9YASgSCjB
	2DSLCywBZezqgYIm1fRcPr4v8cmrhRwKktjcHrrP5sGLShSTxgOwaHgh6vnCw5Rsfz
X-Received: by 2002:a05:6122:547:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5c981d5aaf4mr9148100e0c.4.1789488249269;
        Tue, 15 Sep 2026 09:04:09 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982b9fac504sm15053906241.8.2026.09.15.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:04:09 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] Bluetooth: hci_sock: reject out-of-range OCF values
Date: Tue, 15 Sep 2026 13:03:58 -0300
Message-ID: <20260915160359.3107468-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw HCI socket security filter has 128 OCF bits per supported OGF,
but masks the 10-bit OCF with 127 before looking up the command. An
unprivileged socket can therefore submit a reserved OCF that aliases an
allowlisted command modulo 128.

A conforming controller should reject reserved opcodes. Nevertheless,
the security decision must apply to the opcode that will actually be
sent, especially since controller-specific behavior is outside the host
stack's control.

Reject OCF values that cannot be represented by the security filter
instead of aliasing them onto an unrelated command.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/hci_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9..6413593eee 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1881,7 +1881,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		u16 ocf = hci_opcode_ocf(opcode);
 
 		if (((ogf > HCI_SFLT_MAX_OGF) ||
-		     !hci_test_bit(ocf & HCI_FLT_OCF_BITS,
+		     (ocf > HCI_FLT_OCF_BITS) ||
+		     !hci_test_bit(ocf,
 				   &hci_sec_filter.ocf_mask[ogf])) &&
 		    !capable(CAP_NET_RAW)) {
 			err = -EPERM;
-- 
2.43.0

