Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A55229B18;
	Sat,  8 Aug 2026 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149359; cv=none; b=CJVbmu9gz5N2/G+dio7SLIpRBr39x076oXGrPJs5UsIlFv4LK1gsmi0Nt2j6hpde1jyMRDuOK+uZAyVigeomKlr5MrzLExdCZ3gAgLW4co17MeL0OiK4tvcRsr7zw403RwDvC/5O9MUmjSLrD971gp8dUVE2KTnGDouyLl05uK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149359; c=relaxed/simple;
	bh=9NV5KhFstPq2OlEECq8sc3thgW2vWCQpx/TnjbQtg9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nYU8S8/Dfml0UOvV8nB46sCdcsVB+oTZCbswuCRfPkV3RfNvFQn7H6W93F5YHXmr3GnSwY2HNPlJ5lBWKjVv4iRsjTZz61DSFbvTxGkK1gvl+FGwwaW2oebMA3+fVWDtqdyD/O/x+J5HT/U7JJZS4nkfkfH0oKIDpBA3SMLhvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdgMXSTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdgMXSTH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CC99C2BCB8;
	Sat,  8 Aug 2026 00:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786149358;
	bh=9NV5KhFstPq2OlEECq8sc3thgW2vWCQpx/TnjbQtg9M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SdgMXSTH3ynurqrrv/K25pF9AiJoFWUailsK++b6qcu6kMUDb4P5sG51V8Az1LUFi
	 2f9u/i3uJK4HFr/4/odDt9fEZ7r2ZbVNdZe9FrGG200Ez6X4kNaB5C6qh4mD76OYbG
	 3h8+JdxYokEvYe/dCDmnlA8jJaVXBwDj09viiEE5IHXVIINarTaiIGfPcWyYF4WLr9
	 C+PRbf6nHu3jfWhr7V6FXaWpE5Z6NXx+rs/lfER7Nm6N26uCmBinnxQWeFuB19aEXR
	 ijtJC6yUKbn5HTy+DZYgcx/gi0+g3Yr9rsu4rOG1iYpKUAMs9YVF+YV7+WDw/UBvJn
	 G/SsmsJ9vlpFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAAEC5AD2B;
	Sat,  8 Aug 2026 00:35:58 +0000 (UTC)
From: Casey Tunturi via B4 Relay <devnull+casey.samaritansolutions.net@kernel.org>
Date: Fri, 07 Aug 2026 20:35:13 -0400
Subject: [PATCH] slimbus: qcom-ngd-ctrl: match downstream DEF_ACT_CHAN
 encoding
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-slimbus-def-act-chan-v1-1-fd542efb3d30@samaritansolutions.net>
X-B4-Tracking: v=1; b=H4sIAMB5dmoC/y2NWw6CMBQFt0L6bZNS6AO3YvjovdxqjYC2xZgQ9
 m4RPyeZM2dliWKgxM7VyiK9QwrzVKA+VQxvbroSD0NhJoXUwgrD0yOMsCQ+kOcOM98tDkZQ68E
 4gJqV6TOSD59f9tIfnBa4E+a99TcivZbylw+NgUvEcR7HkM+VUl6S67y3DaI0ziolNdQtYAeN9
 J12wg6akPXb9gUEzzu6xAAAAA==
X-Change-ID: 20260807-slimbus-def-act-chan-b70e4fb7abb1
To: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 stable@vger.kernel.org, Casey Tunturi <casey@samaritansolutions.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786149357; l=1541;
 i=casey@samaritansolutions.net; s=20260808; h=from:subject:message-id;
 bh=e+Q5bDUByME3v5es1Uq1PGS+sTl936AilMSdVkoqZLc=;
 b=a/xPXsw22g09JQ+s5pQ5aOdlYeYCoHIxbI1RBc18HAnf2Bx0vvVajzqTLPH1wp5w3JUUE+fJA
 4QJoSeL6h+jBzT2XrKBvJsFTpkiVKJEkXE2HRbVIpMxq0MszPOj2uB3
X-Developer-Key: i=casey@samaritansolutions.net; a=ed25519;
 pk=oAg9oAsm2ZYWlQFWe7kijWzWnqsQZ/KIY59MAWrTRzk=
X-Endpoint-Received: by B4 Relay for casey@samaritansolutions.net/20260808
 with auth_id=926
X-Original-From: Casey Tunturi <casey@samaritansolutions.net>
Reply-To: casey@samaritansolutions.net

From: Casey Tunturi <casey@samaritansolutions.net>

During my investigations, and some rather incessant cross-checking of
blueline's SLIMbus path, I found that Qualcomm's downstream driver
packs the first DEF_ACT_CHAN byte differently from mainline. Bits [7:5]
hold the data format; bits [4:0] hold the five-bit client number.

I changed ours to match. It made no immediate difference on my own
hardware: blueline's current values produce 0x0f either way. The
downstream layout is correct and should help devices that use upper
logical-address bits or a non-zero data format.

Fixes: 52490169cddf ("slimbus: ngd: add stream support")
Cc: stable@vger.kernel.org
Signed-off-by: Casey Tunturi <casey@samaritansolutions.net>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3071e46d0..14192380d 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1018,7 +1018,8 @@ static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
 		if (txn.msg->num_bytes == 0) {
 			int exp = 0, coef = 0;
 
-			wbuf[txn.msg->num_bytes++] = sdev->laddr;
+			wbuf[txn.msg->num_bytes++] =
+				(port->ch.data_fmt << 5) | (sdev->laddr & 0x1f);
 			wbuf[txn.msg->num_bytes] = rt->bps >> 2 |
 						   (port->ch.aux_fmt << 6);
 

---
base-commit: 55f2ea9ff83cc27a85526b14bc9b32f96a08d6ec
change-id: 20260807-slimbus-def-act-chan-b70e4fb7abb1

Best regards,
--  
Casey Tunturi <casey@samaritansolutions.net>


