Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41E1F5821
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777301; cv=none; b=kk+VUXXsop1z/GEBjlviimRZVLk8oqp4SWCv+YfO83+CQ6NGBXHvs94wmjJfIdzmWpgC6B0NZhCeAUymrp/yYcZ5atNKkNW0XRv0mhcw2VfqtrImVUknyLPnmX9CjFKv74YuQ2H+Esy+To9Q6+gmdsGxb5WWUfD0PpNm9JCch/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777301; c=relaxed/simple;
	bh=r8iYdQWHa9VJS775/4n6zn3PGSHvLkZImtets05yhb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2v27LVwZkUfE60wz7vKdv9Kuek6QDhGW6THqEAqIhGulLR2gvQUq1TL+sRn4GBS/0leVhidQZmwD1YMWJNVD/HXnISOrZdxm6tuFoRi7iknTC5PgqpuHAchOgaqlgFebeCTQ3EDnJTR+ZWXJLlMDkJzNiQwDTay7cVO9l2uJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qF3cM83L; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF3cM83L"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cee9b74ee1so1425085ad.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 20:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784777296; x=1785382096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t/Igs/v4fkYLbH3ZnRzuIP4kc2pMGS9giRIUagxHqkY=;
        b=qF3cM83L8CqP/yOI7qRqfqmo6O0zVq2lGzy7tOur1sARKXfJ8yMq7pjepgir8OpGvR
         YvPDg+kdLnOAcFK+LpJ1woxDcbRB2jNdCTEs6N0mfJYf4coPIfqOo1GJbAYqQ+08i45V
         dvuXohs7IxLXgkrnhEvwAuieUc3yAf4qECUuXgBDNXkiZ2YbAawWCfbk9aTXLMTbMHGr
         zDrL092p0SI4UdJONd8sXaB38XBEcNuYG6QGfC9aFpydXmC1hFt/Ec521C0Z1HWSWAnK
         k/KkpXBn2VPDUfaxymXJmWP4IgTAUumbVLsAaOH5Y6IV6kLhB13BQtfZSoETVkaGH6/o
         UR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777296; x=1785382096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t/Igs/v4fkYLbH3ZnRzuIP4kc2pMGS9giRIUagxHqkY=;
        b=ErBIG7IRirsDzpriyQyx9ZfWSqg2TZKNKG4eimsdzoajhi78IlRHnmjtsK6OArBfdS
         gvQFQybG1jZfMjDlKQoRXEn6gEFnUWLvsMEO8JfslHMS0p6J/TT1dZWy8q9m3w4m1bKL
         o5JC6oFTEevk+ASEsFBpQg/LCbddIWDqjYSB6ikrFrtQJCk8OQlaYEiyXGFafLLaFwfG
         CIIQ0HSpbGyZr9H62tab6mmUJqLAa3E2jm9WGYfGi0OrJ39geafI2lfYP2aDCE//2Ug8
         bzypD4eogu+e6VOdiiWSly4qedU2+6fH6C/Dr/wGKlBY5JRMqsNFWxbPmI3vSrO+dbPw
         UZyg==
X-Forwarded-Encrypted: i=1; AHgh+Rofd3qnYLTKF+sjwzy6Td34YSp3Hw2+9750derfSMTlwMbXAMqqpl7hZOXkVQ406gGlfHBKRgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJx1zQcVIpSzN14ed5J9qkNg8nk6LfXmE1OfwkjpQOdrKYXDR
	2zAKVUNXiZtWCl2NYNiIwxkF0OEMdJmqTaa9SHjoKLPZXXrBVXpjPEv9
X-Gm-Gg: AR+sD12ITqryTmdz8NtgmVOxOhkLp4PqjoDX8/LOJ0Cit/btH4ysL9CxPCzgIYqgzR4
	63Es658FYg68fsQ55ScamhKMSow+IRFhIEMhXoojwVLCrYrplUVaGYma7oWRIteOqu1YIoS8wvB
	PN3Li4u2NK6CJgUJkVKK8gGXbfD6ih1Yp/0ouXNKzfaSOJ3+5FdHf34PJlm5l4N0P8FL2k6iJKr
	AerW3TCIjPFXx25A4g5sirT0ELj1vbYl53VkbPGgQlPpo8mtPxlzD9PASRkyL9klfWlpKAg8DGS
	J37Fo1XKQ5NGjs73tgj2pvm1NpJUm0aj0zKyAhTSQA9rgk6fWlTlTh5w1yXkCB0W7P1zNIjend0
	PAmLTqJu7qD090dUDcccscrgz6UGnQDdcMwL2qEuVSBF2s/zPtJCUKhZaxJOoWYS1yqdq5V5BnM
	z5iZF8tLKKu9HfdigJpTrlXtCgyRkgaQpXA+ncH5GRs/wnfEfeInIr
X-Received: by 2002:a17:903:3c70:b0:2cc:fe03:dc75 with SMTP id d9443c01a7336-2cfa748cd86mr17871995ad.27.1784777295936;
        Wed, 22 Jul 2026 20:28:15 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd7157sm24538485ad.18.2026.07.22.20.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:28:15 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: jikos@kernel.org,
	alan@signal11.us,
	padovan@profusion.mobi,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kudo3228@gmail.com
Subject: [PATCH 2/2] Bluetooth: HIDP: validate numbered report payloads
Date: Thu, 23 Jul 2026 12:28:07 +0900
Message-ID: <20260723032807.1616487-3-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723032807.1616487-1-kudo3228@gmail.com>
References: <20260723032807.1616487-1-kudo3228@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hidp_get_raw_report() waits for a numbered report,
hidp_process_data() compares the expected report number with skb->data[0].
A connected HIDP peer can reply with only a DATA transaction header,
leaving the skb empty after the header is removed.

KMSAN reports an uninitialized-value use in hidp_session_run(), with the
value originating in __alloc_skb() through vhci_write(). The transaction
header checks remove the empty-frame reports, but this report remains until
the payload check is added.

The comparison can also consume a peer-controlled byte beyond the declared
L2CAP PDU. A DATA | FEATURE response followed by an extra 0x01 byte made
the current code accept that byte as report ID 1 and complete
HIDIOCGFEATURE with a zero-byte result. With this change the malformed
response is rejected with -EIO, while a subsequent valid response still
succeeds.

Require a payload byte before comparing a numbered report ID. Unnumbered
reports continue to accept an empty payload.

Fixes: 0ff1731a1ae5 ("HID: bt: Add support for hidraw HIDIOCGFEATURE and HIDIOCSFEATURE")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 net/bluetooth/hidp/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 194208d03d18..f5bdf9f1ca63 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -543,9 +543,10 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 	}
 
 	if (test_bit(HIDP_WAITING_FOR_RETURN, &session->flags) &&
-				param == session->waiting_report_type) {
+	    param == session->waiting_report_type) {
 		if (session->waiting_report_number < 0 ||
-		    session->waiting_report_number == skb->data[0]) {
+		    (skb->len &&
+		     session->waiting_report_number == skb->data[0])) {
 			/* hidp_get_raw_report() is waiting on this report. */
 			session->report_return = skb;
 			done_with_skb = 0;
-- 
2.43.0

