Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272475;
	b=FclJg5s6e1kD3TXmlv9lsaZG7xMu0Ym7zoPsE8X9FErkMU79M6Hjk60Hrp3emfBTzLkP
	 XupzHXBmW8Yx5kBVVehuVVmB1dQzPCWkg5fNwiosmd4ha7bS84IKISDqplenEI52+4MRa
	 iseibNevMDv3fppaLpTEgxNnVkjjy1TBVux9JoGYJk69WJPJEDP2c6fHsX+Zjt4ahVAxc
	 yLDCHFWfqxvM/7sPts/SO5JnvxXvbhQZRZ3k63xIa/pMy8eLLYc/IDSVDJlkSR752+Yor
	 P/ngs+nmY3CePh9MLgOK8JarsJsQQdKDP1Xyagi8RVas/i05PE55j9LaR8vr6koCVNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rwVGG6BihO3TDfhu94hs+7LmdNprAIh+TUG8dJWrqQs=;
	b=XRbB+QxIMD1Bej2dziYWSV9OWskjkvC/V+ZOFB9oEIW0xdaMZrk/jAmBr1i1/lnXhWYV
	 RjXS4PPXbzlAZLQ62YjBI6s6Y6xtMPaKtz9/V2SLsbZkcpvg48H6WzkeNkRzuZF3Xw8qt
	 VOb22KfLgLMobQHpf0Fhnagsqj0pB1+tHhMziP/rSqpLvkcvkk7edvkqd9NjHZ3ntMI7J
	 lIAog6CasibkuFT4cCD1UiWUfU+AST6nHFhz3vyd0zmNEYGbafMOqAT8YtOt/rY2PMSbg
	 AxaKNDT6sgD+PAu5xk4sV1kcl0jd8z5nPOXa0xJsatsBdI8KnPRbSUf0tpGS0oSA0Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqj9eH+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9102606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqj9eH+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5253B1F0089F;
	Tue, 10 Nov 2026 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272474;
	bh=rwVGG6BihO3TDfhu94hs+7LmdNprAIh+TUG8dJWrqQs=;
	h=From:To:Cc:Subject:Date;
	b=cqj9eH+weLPJIcV+jkGhlA54IBeP5/XA4Gft5fk8gotKfXBG7O3Bn5PIbqZsV9+7o
	 zw8nVS0nngtZ7KANxmnk4u9AOeTPJFP1SwxFP7vNxrMxMyoOqQUvKc/UFztQenBwzv
	 gW7lrx0Kzu/t3kcMOxzXG1oqd1Ois/W7yeq4vpQ6s1nJqyP3FV1EUPKBxFeAL7kNPe
	 eoWqOnmlgIfe13A9pPVki/r+CJyC2lhsExdWi3tQz7t2l27/RfJGQmi4+U9GTtXj0K
	 2AJ80eyKy+XdhPRxsFiBzY0zxwNbCUMKyLQ4mN6T0eDa0wkeG29/XYrsTeVIBqubJW
	 Pdn6Qwtt8oWUA==
From: Sasha Levin <sashal@kernel.org>
To: gianluca.balboni06@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:12 -0500
Message-ID: <20261109200112-failed-7.3-1e73257dff33@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1e73257dff33ff851af60d5bb00d73893a8b6dc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200112-failed-7.3-1e73257dff33@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1e73257dff33ff851af60d5bb00d73893a8b6dc8 Mon Sep 17 00:00:00 2001
From: Gianluca Balboni <gianluca.balboni06@gmail.com>
Date: Sat, 31 Oct 2026 11:21:36 +0100
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop
 16-by0xxx

The HP OmniBook 3 Laptop 16-by0xxx (board ID 8EE3) has an internal DMIC
connected to the AMD ACP6x audio coprocessor. The BIOS does not set the
AcpDmicConnected _DSD property or the _WOV method, and the board is missing
from yc_acp_quirk_table[], so acp6x_probe() returns -ENODEV and no DMIC
capture device is registered.

Add a DMI quirk entry for this model to enable ACP DMIC support.

Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Balboni <gianluca.balboni06@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20261031102136.24600-1-gianluca.balboni06@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1d06b2a16e58d..4908f4cc147a3 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -780,6 +780,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8DC2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EE3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.53.0




