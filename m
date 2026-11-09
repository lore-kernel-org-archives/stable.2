Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253338;
	b=hhkYepVeC438C4AuEerqNgAZseka+xjQPYq3WhYGa3sXztotKbkCeQHKTYabxxNVPEBP
	 RdwJmZcXUhBtQ+7hTDVVaNwEj85GanDVzqeNu/RWlANcNTSkJua//9IpiYxI9IwPe0goV
	 Xs7/RAhO+vPeSVHi5A8gFR53JJxkYgqwdMi2LwbkrsyvlkCgAY1tLrtWitrDdj/9qneI3
	 w7bGwwezlhyGNofwAzpfaHz5KD77Oenr3bo+5s/mq0kyyzPI3qTOOqcp1ilVGugb++3KP
	 3U5oPyOmU6Blow4l0wTiwj2HYFyUDgSjNsYNdORXyocMQnNgA9c/ze6Ivf1NkDhi3jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lIwwhY19T6f0qHtgPzyazjtCz8LaUAMO7sgruWI+rDo=;
	b=kJfzEvs0/li2cNrqMd0uHsOf23CoLPtwu4jLcf7xn5YuZhhT1vl/cnFjsevR0HAxjDCS
	 TQjJ2J6D2GQjas1qC0Dd6HeerdMgxaTEIf+VBlyugiEWffJd5BhY6EVdudKmNwLnKNyjg
	 K8VKMpLlrGQ45f4f/BfMaEr7jyR34WX2c+0m/v+571XHk7KChtJCVQsBuZ2I5gqu/ISky
	 +EE3Wx0LamF/Ku24o217PbXQVUWpDvSk1u1p983s0sl3asIlGvcUWgwYdIchgTKDRWlc5
	 k7b48TwvCCm9yYSckU49Zk+d1EqD85WEhnfxp5KFiGoyLXUy12b0IkRQWDddPFm5FVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hvgzSntr;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10631606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10631606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hvgzSntr
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed0e2015aaso5284075ad.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253337; x=1794858137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lIwwhY19T6f0qHtgPzyazjtCz8LaUAMO7sgruWI+rDo=;
        b=hvgzSntrjv0Eepibl4tNE0CfHPMpPsJpxLAyFyYxacmIqWv/b4NvE18kC2Ro01MgZL
         ocE5YUoEl0/vrDPRWTPCdyX0fYILnlZAnwCTRrPOWCAULCoxGqZNJrO4HRGNTesBTQSH
         GD1wYH0JKpoRvpCwiEstogHvibfTEZU9eCQtTjDnfIlypM3vbzboFs0kZQ1LnjN47s6o
         UWvaj2xwsIOgdGWFc4PapXtdz9bx0M9FphhRD1OP+Yq2JuvlfZtZLRPbU8wrZSwq1iIk
         9VZs1MkkYPTrJX0M5/3965WY6DdK5lSFyBYfo3g01oKM473d4DGLqbL5qNX8RK+7xzYf
         mrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253337; x=1794858137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lIwwhY19T6f0qHtgPzyazjtCz8LaUAMO7sgruWI+rDo=;
        b=AYo4wrFHfAlyDb9i7a8QnbzJVEJcnLXSg9apH/VY8PSNF0zMx7KuJT+aU5MhQgU8vD
         es5pwdqLTCMgUcJAbguCtHHsFfptcSBjplc1JkV546WjGw6kVjXMSkvv/AGpBDapcLap
         ALpUDQRKx661gwOXu2J/TQf14+yCyPgKguI9rRe+pZsq0MyFwdFadkojs8kt4qUdokSm
         NUul8Kwt44+/BpBJpjDiGuvdbx455bwEEi9nTiKi6yjhBjRH3Ix3CasIWsckiE/saJRD
         AA+r7slTCcXBNXXD8g1lnr90oBQviwF8XDTt0NQ73ZDkEusWshqw9zY/SIO5YFXiO1VF
         LgVA==
X-Forwarded-Encrypted: i=1; AL+hErFzsBYLqVbEP6vTjn67HoPW5cj7fO5/LDq2lEXRqbs4LCm1FBiyhApsAUP5BqPspLpQlFK2BnU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Rl2h1RmmADMysD493ZHI+M6rEIX5ToI4+y4C7rMM2Sc+RxOfW
	8mvqWyoCOI29s4nHvADHH/mDmbmxVk821MZ7EYmGO4phRDQcSkGf4KkU
X-Gm-Gg: AYBFou1BMnSuSTDyu9gd+Yj89j90gYzXiUA1kcorygf2bx8zb+DBRAanaJm5JY98IxD
	buxR/OYQF+8tDcMBL1+cpRW2+fj1/3Hc7ApvlaO0XAX3u7CGRv5tjzJBCWDYC+1fgustGPww10d
	Hykc7H6kLoglTCU05RHlaWgQcpoo+6ltlpLlALNn3JAQEFpJbjjLVDs08QER6D6WA3wRWexfix+
	KKTPXPvjdqqHRL7MvW0fJFgWE1E0HGzwUDFVFUxwi/A9ei07xm53pzf6mc921qRAFRrlXzMuQd8
	5kCmTBrhUoWl9lgxf1omH+cJ/dR3dDy5yCf2kaoCiqDlEmU8KpfcJUaPLXG7K+l6YSokZ6VuvVQ
	nsdfJ8JzmGJBTCwZ/M55ab5Yoy64CGKUo5Gt09iIfx0Rjk4XqvEy9Mv020RUZYw9KWWh1AvngrM
	/SxKFlRYVAxULByV3NM1+J1qE1YZr9CDzetVqdanBogiHZi2hyFuR2w6VE/rB2SRiNPz+VWoXlw
	iJDntwcg0saRPrjaDp2GTp3jwPDg65mGSX8FrfLxmLFS2S0scdrMP/WzznolhYQ4ybWOJbAwMKA
	AmN3nvTvOjfWcoweX14xE49nW6+ZRyqwbWj34SRUntOrF6l5uhZlup+xB8n7lacfbXDGp1MjC31
	odD9h6kVg5G0FOJN3JXhbNT7FOpAbEavRqynByiJCYsbF+d5SZsk+Xyo=
X-Received: by 2002:a17:903:22ce:b0:2df:90d4:7758 with SMTP id d9443c01a7336-2edb9164135mr1348605ad.23.1794253337360;
        Mon, 09 Nov 2026 11:42:17 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm1388585ad.13.2026.11.09.11.42.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 11:42:16 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: linkinjeon@kernel.org,
	stfrench@microsoft.com
Cc: icb@fastmail.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	ematsumiya@suse.de,
	lsahlber@redhat.com,
	hyc.lee@gmail.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/6] ksmbd: check a request before signing STATUS_NETWORK_SESSION_EXPIRED
Date: Tue, 10 Nov 2026 02:41:42 +0700
Message-ID: <20261109194144.22814-5-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194144.22814-1-mike.michalo@gmail.com>
References: <CAKYAXd-Jo-ObBDs-AdGfaM+QmDsot3gj1g0oJiyDKczoUDg2TA@mail.gmail.com>
 <20261109194144.22814-1-mike.michalo@gmail.com>
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

When a session's Kerberos ticket has expired, smb2_check_user_session()
returns -EKEYEXPIRED and __handle_ksmbd_work() signs the
STATUS_NETWORK_SESSION_EXPIRED response if the request has
SMB2_FLAGS_SIGNED set. This happens before __process_request(), which
is where the MessageId and the request signature are checked. So the
response is signed with the session's key for a request whose
signature was never verified, at a MessageId that was never checked.

Anyone who can inject requests into the connection can then get
responses signed with that key at MessageIds of their choice: a
signing oracle. Reauthentication keeps the session's keys, so the effect
lasts for the rest of the session.

MS-SMB2 checks the MessageId (3.3.5.2.3) and the signature (3.3.5.2.4)
before the session (3.3.5.2.9). Do the same: sign the response only if
the request passes both checks, and otherwise answer with an unsigned
STATUS_INVALID_PARAMETER or STATUS_ACCESS_DENIED, as
__process_request() does.

For a later command of a compound, the response that is current at this
point is still the previous one, so the old code re-signed that response
instead. Leave the expired response of such a command unsigned.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets expire")
Reported-by: Ian Bridges <icb@fastmail.org>
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 4430c8d6393e9..bd4db44f06cd2 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -107,6 +107,32 @@ static inline int check_conn_state(struct ksmbd_work *work)
 	return 0;
 }
 
+/*
+ * The keys of a session whose Kerberos ticket has expired are still valid,
+ * so STATUS_NETWORK_SESSION_EXPIRED is signed. Check the MessageId and the
+ * signature first (MS-SMB2 3.3.5.2.3 and 3.3.5.2.4), so that the key never
+ * signs a response to a request it did not sign.
+ */
+static void ksmbd_sign_expired_rsp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+
+	/*
+	 * For a later command of a compound, the current response is still
+	 * the previous one here, so signing would corrupt that response.
+	 * Leave this one unsigned.
+	 */
+	if (work->next_smb2_rcv_hdr_off)
+		return;
+
+	if (ksmbd_verify_smb_message(work))
+		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
+	else if (!conn->ops->check_sign_req(work))
+		conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
+	else
+		conn->ops->set_sign_rsp(work);
+}
+
 #define SERVER_HANDLER_CONTINUE		0
 #define SERVER_HANDLER_ABORT		1
 
@@ -276,7 +302,7 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 					rsp_hdr = ksmbd_resp_buf_curr(work);
 					if (rc == -EKEYEXPIRED && work->sess &&
 					    conn->ops->set_sign_rsp)
-						conn->ops->set_sign_rsp(work);
+						ksmbd_sign_expired_rsp(work);
 					else
 						rsp_hdr->Flags |= SMB2_FLAGS_SIGNED;
 				}
-- 
2.43.0

