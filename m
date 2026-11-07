Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048160;
	b=KPvfAgxfQhLIKZyObKVKez1494C0Xx3BFhz+oqapVssPQRUNwme+sFaQ7TYzqARPyr1N
	 jqg+dC880Jt2X7KwU3rusPI7tq/SfdWXla3jpa6P3ZukTRDUkrS8Z5s1QWiozRv3j11Et
	 IufztdQMvFnUVSzed6I6qJ638CRLWX+0HBWXhEYuY6YvkE19NxlMRxg7RR8HiSrADYNng
	 QFfS82plcXpldZZgok8BUEiHFsGunPtpB0M1jVSyEdKHk+Wa5+bF8j8MjdrJ46CW5FnRD
	 1eY0pR5kFFBmpbVOekUANC0buHa1Fhvvv/LFDRd5N+4nPg5OIM3KvmWTs0Pk7cvKw6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=366QEZVoRHFuhOn2C9dEkV96D44cDyR08r4iBbUnyTk=;
	b=TDguZE0/ORCZI95pAAX8B0YM9H/+ifSuU59XglXeXBXooeVnSUSrav0jXH9JEmrfT9ip
	 OSZC75As94UJ+DDQSeGlE24RnjUpfjKnpJovI/YWqC2WfADqp2K5f24VSqdbZFTJVZCyl
	 AsWIy1TbyNtTPu6CWvvk5j/NKMGIopPtLy4RomU+A42Y1wpCTmMFKOK6uyHIYKhmkOvWc
	 RQ0YpoksCi6NffIoWtnTNBqlga/zbI3fgyRyRcabUXkL4W8gEmDMEqk/n+y3/I/yAS48v
	 mF8fBDTO5LO51071XjVnRhQSaPhN4zEbXv2kVGJ5x89srsBefwD1kPKAV5WKejAleQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1dqSY7a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1dqSY7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8A41F008A1;
	Sat,  7 Nov 2026 10:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048159;
	bh=366QEZVoRHFuhOn2C9dEkV96D44cDyR08r4iBbUnyTk=;
	h=From:To:Cc:Subject:Date;
	b=P1dqSY7aX4qae7KS+6DnLiH+4las+1k7fmvY5F4W6GjDAF56Z2YhWJcmProsCQXYY
	 eYADRyzyxteHlHaIKJCOTLQhaJYjbnF3aHrhMXq5Rw81yuoZNq+h8ypNQlZlDdEyZk
	 z06mYtdXUVatO99LDM6yZYcyYS9LitCEgvKxUcVbAo9WnNS9UZGZuejb9JmGyklNW6
	 tOeg5iP9nLN3eFuCkBWoD7qW5Ehru3u9W6MM7xrq5SQYF5uTu+AUPojgXhoc6Dbp+G
	 18CRD7mPhVwVarIEKHQANnZbHaWEr67BDfAXvfsHI/N0a6lwILRP98J4xXIv6Wh6g/
	 XqnmpXYoF8xbA==
From: Sasha Levin <sashal@kernel.org>
To: jm@ti.com,
	m-shah@ti.com,
	nm@ti.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:38 -0500
Message-ID: <20261107054237-failed-6.1-8ef8a0e38d13@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8ef8a0e38d1377c6d51c06f95c64d87641b2c717
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054237-failed-6.1-8ef8a0e38d13@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8ef8a0e38d1377c6d51c06f95c64d87641b2c717 Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Wed, 9 Sep 2026 16:47:38 -0500
Subject: [PATCH] arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as
 OUTPUT

MMC clock pins must be configured as OUTPUT-only per TRM [0] with
receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
PIN_INPUT to PIN_OUTPUT to match documentation.

[0] https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals

Fixes: d19a66ae488a ("arm64: dts: ti: k3-am625-sk: Enable on board peripherals")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260909214743.899477-11-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
index a5922bd746d86..8e07d2c2e62fd 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
@@ -98,7 +98,7 @@ main_mmc0_pins_default: main-mmc0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x218, PIN_OUTPUT, 0) /* (AB1) MMC0_CLK */
 			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
 			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
 			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
-- 
2.53.0




