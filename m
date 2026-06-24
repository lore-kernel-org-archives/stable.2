Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51D272801
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303386; cv=none; b=dca/gqWr2w5ZLee3I7fUoBjn4QLEJ3x3+Wu7QjpyIUdPe0YLoktfNEhLieen6YOYUHEEou27MMCPLC4wm/4HWsNXG76+azdYrw7WHX2rVoird3GAMppfPIA0OOHYSiyhMHkDMm2uSnBecwt6hjap7DtbLpthFNv2q34boI9LnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303386; c=relaxed/simple;
	bh=8mTZuUoiyhNRN3gTKiUmzENom/VFrrl5XjY2DI/t9pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBI1s/qnE8R+mim2+4NggOydBAWKrsW9N1FhCPwHNe4HM3Qp9MosrewhVlqAHXXj8ISZb8XvYTS31y69MqlwfL81ui7M+Lbgkp/a5THVvJ7WumjCpgcdCoeLt9UtTGjuL50bq91ZXurEBalzk9+OeUedpMa6JO9JccJlWdz4bTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2raHcm4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2raHcm4"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-399389dae7fso10076221fa.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303383; x=1782908183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWN+ktVTYkpSQqdNFGaR2EYDD+puHcc21cFbcKJgBfs=;
        b=V2raHcm4aq59i6qi0YfjMaqw8TXp1JbHv1JaNVBJ1C0bXP7+3dHBVRQqMBY0KHnvMm
         AkG+HFYcLqUUWHwx6Ch0UQEWHrMch9cq/7r1ANOBfHHgpPQPLZSa7kQgD+XCS8rW2QFZ
         jO1H2gIPQwJmogZ1qKqrSIX9k/VrTj8zNA5ll/vaw8fEoYF1VoG129P0Ayq1mYKXdk3+
         pXm948Uir2MbhKX1PCUySlzsLAQBHYuytszwn91cmxfRX0tKzwy3Irt0hHiPmyjbwVaT
         XI9Jt/Rm1oyumHGhgOCN8c1FBXaOvtm4XIWMGeJPw9TJUD5Nmrn0d5jO6QJQi/50LnSD
         8ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303383; x=1782908183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWN+ktVTYkpSQqdNFGaR2EYDD+puHcc21cFbcKJgBfs=;
        b=U5g5Ec4NZIXl4sSxmRBIvlJ3xlt+U3/kNAbvEQqWaBSeb2FrJhs0jw7S9yJI39i1T9
         QVxLrFW8pjc05bGpW5XsUxC55OpUQ2fwnBoHC06xjj0Ym/TN4pYlpATUCmrITqCt0RSY
         bc/VvE4oHw0a5rUJtZZIkPFWV8l+5LstuqHUh4UCIX5pnBqQNxzzvDktt5qbbmmVpQtc
         h8YL7WUxL8Ptf3OJGaghecVpL1PyD2tA1eGmLYlfUo6aERUhywgJQabFD5WlrzIX21E/
         +DKHkdu7E4UIji9xE9mXtRXcNVT0wT8XzmC8TFjPrrvu9NRK9MGZAogllclDgB5yuVmz
         Jzig==
X-Gm-Message-State: AOJu0YyVxdrr/P2xy9FVQKZv2OCI+RqD5Qqq6i0e4bA8aC77pmzHp1sp
	x1npL6uYVzo7Ft899jSDUiJEH3Q0fgffujJ8wftj+ooVwfVIE79sGOz+cajaof417hE=
X-Gm-Gg: AfdE7cl1vPei5ELdrAU1pdXmOjhyGQBIXnx+IG9ESXTFTx1mpLQhnXiTXa8y10oaAme
	kvVvd5IZA2PsqijPBSgZUwP7Kfv9I4R8i/dn4GJjjGZDkAYg/N/OI3gM0KMgLiSFhZiIwuGnJTd
	uNpEx4bi2186/THb2KOX+hpgqqz/gdPMTwMF40v5J6Vv4c9D2LhEPOgCrF6HfCG4I/uQ0uc5mpA
	QSMQ69rwU110vhpEMyVEX1EGv169Clw5KJnAsbqrhu6frhyFh7YP691Sso06Tja33LdNkBJEjpZ
	ou5zgz8JJuiA1jayy8HrX0d8MUYAcZpJrjm2uIFpnsz+k0PXms2BmUQ7BboZ50LYYMtDL2NQML3
	8arLaLukkfExcQR8wsNzMIZJ1IpygxAOtYpRj+4QN5+ESvGDvn5mVHMBPwZN2yEcidL2VyZA90k
	LEfVEYsfXXY2a8g/+qjLrjIsUwM6UK
X-Received: by 2002:a2e:a913:0:b0:38e:8357:c5ae with SMTP id 38308e7fff4ca-39ac25ddbedmr400571fa.9.1782303382591;
        Wed, 24 Jun 2026 05:16:22 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b156f23sm33089191fa.27.2026.06.24.05.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:16:22 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: [PATCH 5.15/6.1/6.6] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Wed, 24 Jun 2026 15:16:48 +0000
Message-ID: <20260624151651.38894-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiexun Wang <wangjiexun2025@gmail.com>

commit d119775f2bad827edc28071c061fdd4a91f889a5 upstream.

SIOCATMARK reports whether the receive queue is at the urgent mark for
MSG_OOB.

In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
so they should not support SIOCATMARK either.

Return -EOPNOTSUPP for non-stream sockets before checking the receive
queue.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260506140825.2987635-1-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-52928
 net/unix/af_unix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 32892a40d139..8bd78cad69e7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3139,6 +3139,9 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			struct sk_buff *skb;
 			int answ = 0;
 
+			if (sk->sk_type != SOCK_STREAM)
+				return -EOPNOTSUPP;
+
 			skb = skb_peek(&sk->sk_receive_queue);
 			if (skb && skb == READ_ONCE(unix_sk(sk)->oob_skb))
 				answ = 1;
-- 
2.43.0

