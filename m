Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0A2EB10
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791764229; cv=none; b=W6wHmf/QvCYcuR09l5D/+I6LdOcdecPQgEPAjYdtmI7ci2aIo3B6WF0FVFJ/sToEfy3ZIJBJY1qWog7VnIP+qBhQAmsaAucgCLOtQpExJ1vDfJzt49vQwFu5bVrJQwvVcI7ThDDS5O2CTW+SmAqLIMPLax/LVOIvblmDCfMjUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791764229; c=relaxed/simple;
	bh=WR9ZRx0OG8WB8FU8j6N84odGtF7ArWFkBQwxc0m1e9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E43a6PQgz1kx3VzgcweN5GuYhPi1gBfx9Oo1zhRPevxS2fYRxiR+Yqo//gYYWrWEQZYXfZBrJ6eOGIMVMT9YNgxKgrA3PieFMRXPA3M31zxSf1Z68Y3OPdS2i8CL/0eU1tMv2N7duLn9GjTkFSpAGa8Poxq+4GeEuigkz1pli3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=YolhH/3e; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="YolhH/3e"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-88b5f43cb8aso350522b3a.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 17:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791764226; x=1792369026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPB775D8RC545nicueL5zti4cavLO/8DRXwfdsdk1Fk=;
        b=YolhH/3e9/G07Qni4iWC3PYrb4S416WW7z2+GSCpnMvx7USgO+w4qE3Zuh/vSV9SCk
         u5GiX9r97I83jntxX3r5EMDhI/uRpmYv+pCsOe53gznqaRQrw4ogprycbLt9s8O/3NqE
         u5TRXEvC3TWGHjX8DQilYDqWPuIhmnbicEaLUEaAHLH6F1il736YUs5hclRm2mPOEZd0
         5d5h40Jm4VCr9LiMFBp4j8sVtxr7boXlEGUxCXqMo8YOqHL1BABa/607tnKy1fwkmhTp
         A/YxR2iBWKkb9c0ywn/mY5JT/OooE5UyBY9YLZxdQEvJCIZ2THudQ1PgrcIEHjUIcWra
         QUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791764226; x=1792369026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPB775D8RC545nicueL5zti4cavLO/8DRXwfdsdk1Fk=;
        b=FMaaiNMGc+7hGVM09qNVx1pwSHi9A+oQhxd8jwI5UgNkTcVDFcwD1OcbWNh6c7sbn+
         H5CeuztvDklqHQGa0/ASnL80FPZOVMelGlJUR+g32JYLhHvAxhR+noB0/7DfAAkR15Ti
         6WWYTrc8XhdZjf4zsXpbYqcN8kaDVbIIS8dGauGB1yyPcVDrc+RJwTvC0+kE1wX81Njc
         JOFucZ8YstPF+HosPKWXgAosaZfbVAkK5/HExbw2JIOOh2N0voB4rOps0SLbFEr4M4Sz
         VQ368hpck5frvYkQFLLaE8NNHbiEASQann/8TYqv08xgqXbgp/fIVCMnhRmzgZYM+zcI
         1TRA==
X-Forwarded-Encrypted: i=1; AKwUvBwvqXAJUAKDharp0xwhon411mTSBJBgnKxNkPTMxrzjeHc7NHRapJVDXADVaem1Fr7dG3XQlkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIu1AeOqP/QGAh+Q2nhX7HFfJ+VOeUhSslbEb/5jSNns1a6TkOV
	seogD/hzYoSeIsCIr4/2N0FaHyHcl/rrBKCHvzrWbjWyptYZTY06WH8vBLsOehttaIZzMLTvcZZ
	HuvYR
X-Gm-Gg: AYBFou2w/kMqLe/F3cpE/CrmbVwjQUKC5XVWiaeZWCjwRDKUBhAYNC2kw0DLFJejiFv
	S6Inm68R/Ynw5RdcH/q9T/qEASu/pOC3BzV91zXecYLV40BDmBGaOWhNgU7GtSSs2qyzoR3JaL6
	T2FmoeoAANc//WlUmYvo05z4mnuqN31hqnmpQgsN7ydvL6VgaoBhLrA/gqt/3b/wcUPjwIQCC4b
	tjwgQeGBvZHMKx86kus8UeQqJqb6Riyq9QEbEue0r55XxOKmZn1gdzjI2Ml8amBO6/MS8WzpGHi
	mBQqfdI3RdNi7t9xiZV/L/2goOYXQFbsinpddyM8reMGoN1qEkXH/uqy+IhIIxilBw+mOvXs6ah
	o6OXv1tdqQZ9YOMsnHarXf5BQCZE+GEhf1XXcaxCxbprKouMo/GlitJfSl+wUzOOaJ3UIyRo0Vy
	xpD2PEuSS6MchLuupqWYTJtjIrIob49DP2AG/YCkbrDPkneUaE5ywXglLyP86XyAM+cbf8HamCm
	IBmeA==
X-Received: by 2002:a05:6a00:178f:b0:886:18b2:361c with SMTP id d2e1a72fcca58-897c3ef946cmr6502691b3a.7.1791764226441;
        Sun, 11 Oct 2026 17:17:06 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c49901fesm3378268b3a.57.2026.10.11.17.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 17:17:05 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: mkp@kernel.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Cc: michael.christie@oracle.com,
	Roland Dreier <roland@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: iscsi: reinstate sessions only after authentication
Date: Mon, 12 Oct 2026 09:16:49 +0900
Message-ID: <20261012001649.2135743-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an initiator starts login directly in the operational stage
(CSG=1), iscsi_target_handle_csg_one() calls
iscsi_target_check_for_existing_instances(), which performs session and
connection reinstatement, before the iscsi_conn_authenticated() gate
that follows it in the same function. The reinstatement matches purely
on values taken from the login PDU: a zero-TSIH login closes the
matching session with iscsit_stop_session(), and a non-zero-TSIH login
reinstates the named connection.

So on a target that enforces authentication, a party able to present a
target initiator's InitiatorName and ISID, both of which travel in clear
in the login PDU, can force that initiator's existing session down
without passing authentication: the teardown has already happened by the
time the gate rejects the login. The impact is on availability; the
failed login gains no access.

The CSG=0 path does not have this ordering. It reaches the same
reinstatement only from the authret == 1 case of
iscsi_target_do_authentication(), that is, after CHAP has succeeded, and
the source states that intent. __iscsi_target_login_thread() notes
before iscsi_login_zero_tsih_s1() that it waits "until after
authentication to check for session reinstatement", and before
iscsi_login_non_zero_tsih_s1() that it waits "until after authentication
to check for connection reinstatement"; the helper called from the
CSG=0 path is named iscsi_login_post_auth_non_zero_tsih().

Move the reinstatement check after the iscsi_conn_authenticated() gate
so CSG=1 follows the same order as CSG=0. Where authentication is not
required the gate is transparent and behaviour is unchanged, and
login->checked_for_existing keeps the relocated call from repeating work
already done on the CSG=0 path.

This was confirmed at runtime: on an affected kernel, an unauthenticated
login that selects CSG=1 and carries another initiator's InitiatorName
and ISID tears down that initiator's authenticated session; with this
change the login is rejected and the existing session is left intact.

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/target/iscsi/iscsi_target_nego.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index b03ed154ca34e..bddbe29da807d 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -982,9 +982,6 @@ static int iscsi_target_handle_csg_one(struct iscsit_conn *conn, struct iscsi_lo
 		if (iscsi_target_check_first_request(conn, login) < 0)
 			return -1;
 
-	if (iscsi_target_check_for_existing_instances(conn, login) < 0)
-		return -1;
-
 	ret = iscsi_encode_text_output(
 			PHASE_OPERATIONAL|PHASE_DECLARATIVE,
 			SENDER_TARGET,
@@ -1008,6 +1005,13 @@ static int iscsi_target_handle_csg_one(struct iscsit_conn *conn, struct iscsi_lo
 		return -1;
 	}
 
+	/*
+	 * Reinstatement tears down a previous login, so run it only after
+	 * authentication, as the CSG=0 path does.
+	 */
+	if (iscsi_target_check_for_existing_instances(conn, login) < 0)
+		return -1;
+
 	if (!iscsi_check_negotiated_keys(conn->param_list))
 		if ((login_req->flags & ISCSI_FLAG_LOGIN_NEXT_STAGE3) &&
 		    (login_req->flags & ISCSI_FLAG_LOGIN_TRANSIT))
-- 
2.43.0

