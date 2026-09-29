Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD13AD51A;
	Tue, 29 Sep 2026 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691921; cv=none; b=ErRTQ/wc2k7Y1GTS0krKQlHtnfDIiWH3uHv0rkRWC8Yshk/9XRwyMMrywmRlAWv0vY9KS8ZBhQ9zUadSTq6OpFFAdgboVfB0Clwyb7gEObQXo9t68qqCcBOWTwz9E/JaiTrRQSYSkUpYiKwj/nA4vPfd8eB4nbE4Z6f6LdZBq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691921; c=relaxed/simple;
	bh=TT0Zt52k3q2ow7MKikl7hFJZzV58Jn3m5Ro9MRuThwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GGNnHacGQH9kOT9Q8C6w9HBOz0unK8A/EmeOAyX0l7KCE8RyzZ+5wCu2O42Hq/a3JqFGMVZGlair9xsxT7cc4XeY94kHkBL79iRj9iePwPsJ9BVAxpYFxr6tPrrHaaavB15LJr0/RW8YP4WqpjW7VUgWKiap7iSF/k1tfV115GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNdaWX3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNdaWX3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAE31F000FF;
	Tue, 29 Sep 2026 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691920;
	bh=85xj1wiXSyoLF/yht4C9mQFJLHCdiogKv9fjMvxDEbU=;
	h=From:Date:Subject:To:Cc;
	b=PNdaWX3fJr0zA9do0cpO0iD4bfd9trkRlljYRzLaKUMogzCmXjLituLo6iUb1Zn5e
	 wOHAhUmUbKOqaYtDZHbGo9GjUH4ag8gM5m8xwGASX00V13oWWrsLWDJD+i49w0pLGu
	 sX/yhlalW4js8ByOcM+1omnlLPOAeCKhnsgRLnENDRrarUibC7koJ38nShdJObjRia
	 Iq7eNnJTOFiZTubg0UPUK0/pL1iVV82w2dcmgu2ZM3S8qxAPtTWCH9VnszTJX7cqh0
	 xZGyGVQpOsuwMGWu8OAdWlVyDfOhUIZ3zO+NIRdzZSQ02PFXQzjF+b11rU6bE1Wd7d
	 OE2uwldjCYN2Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 16:25:00 +0200
Subject: [PATCH] nvme: fix swapped ZRASF zone state values for full and
 read only
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
X-B4-Tracking: v=1; b=H4sIADvKu2oC/yWMQQrCQBAEvxLm7MC6ZAPxK+JhsunoiK6yo0EM+
 bujXrqpOtRChqow2jULVcxqeisO201D+STlCNbRmWKIXehjz2W+gt/FeJKhavZXXEbfF6fQTdK
 mFkmEPHCvcP2L7w9/tudwRn58i7SuHw9B87Z+AAAA
X-Change-ID: 20260929-nvme-zns-fabrics-field-fix-506fa454e5aa
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Damien Le Moal <damien.lemoal@wdc.com>, 
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Karl Bonde Torp <k.torp@samsung.com>, stable@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=39griNeA2J0KiajlOS+aLyu1xGxKZDOPR0HfUFHRsds=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu8pCjVSm53/mKAnzsB6IaZZ0D2CpCsEgMqydj
 Ww97FRhhguJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCarvKQgAKCRD6UCkIqsW9
 0Ax8D/9paMIkK6BptR6CRhOinxpYa+oKyelk9FHZYfAFuU6gWSFUHlzhg2kicu1aGPwz2RB5LQU
 IbbrcxPd6tjp1NH5yu9PIqef/KZfl7PU6fK/NhIdE1pwdkJnYuxa5mH6qnw2U9uiIOk7JaIUX15
 qE0UaeetckZBmpNmQVom1SS+FXCk0ky0qf/ZAyIUizPxxPKNR4Efb7Y4BbijBk5PeDjLTP2CpRc
 /PoePNp6+sim9T/S7Ip5NMWX+cVGoK4Wj/UddJn19zzfeeRqx1Z0uGYzXT+3lPXNNQlcbx2jV/l
 MXQMkaK3plOS3/jCI4AQcB6LiDQADVz2H2mDXT5lxIxIRGb2o1TCPt7GJmYqkuXtE111lCynVvK
 O5zO0kAhzhBi62Gew4J0PhxgzSu39FdKUXj9MRBxglGGWy/HmEe83tQSGNu0KwCgFMCbw2trHhv
 wjXrFj87ot0TjFy1CiTyTxdtiDZu8I+o0tLNv0TyHIRDGJb9dLufrVVnN6Q2h0Wh3NJ0yOlsJR3
 O9Dk4RpK9sJhqg2cGnvF/i03i35oD5DHy7PiAzvSxnNDAJwp2GOHKzKN6hZNYncPzlc9+b4rWLV
 8xKuEK1QFuJxSyGnuuAvKK5gyUQl1MU9Sb4YzjnlPflsN7CQlDWBYvxVvJY3PYXH87T7x27aK1G
 GdPQxGys4Lx7L7Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Karl Bonde Torp <k.torp@samsung.com>

The Zone Management Receive command Zone Receive Action Specific (ZRASF)
reporting option values for the Full and Read Only zone states are swapped
compared to the NVM Express Zoned Namespace Command Set Specification,
Revision 1.5, Figure 35:

- 5h lists the zones in the ZSF:Full state.
- 6h lists the zones in the ZSRO:Read Only state.

The nvmet ZNS backend uses these constants to map the ZRASF value received
from the host to a block layer zone condition when filtering zones in
Report Zones. Because of the swap, a host asking for full zones was given
the read only zones, and a host asking for read only zones was given the
full zones.

Swap the values of NVME_ZRASF_ZONE_STATE_FULL and
NVME_ZRASF_ZONE_STATE_READONLY to match the specification.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Cc: stable@vger.kernel.org
Signed-off-by: Karl Bonde Torp <k.torp@samsung.com>
---
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 91ce434a7e8d..6248711784b3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1266,8 +1266,8 @@ enum {
 	NVME_ZRASF_ZONE_STATE_IMP_OPEN	= 0x02,
 	NVME_ZRASF_ZONE_STATE_EXP_OPEN	= 0x03,
 	NVME_ZRASF_ZONE_STATE_CLOSED	= 0x04,
-	NVME_ZRASF_ZONE_STATE_READONLY	= 0x05,
-	NVME_ZRASF_ZONE_STATE_FULL	= 0x06,
+	NVME_ZRASF_ZONE_STATE_FULL	= 0x05,
+	NVME_ZRASF_ZONE_STATE_READONLY	= 0x06,
 	NVME_ZRASF_ZONE_STATE_OFFLINE	= 0x07,
 	NVME_REPORT_ZONE_PARTIAL	= 1,
 };

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260929-nvme-zns-fabrics-field-fix-506fa454e5aa

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


