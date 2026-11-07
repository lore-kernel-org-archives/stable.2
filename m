Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048628;
	b=lvvGQIrRFTYT2DBR9renfI71pS2tMbJwA0BTHoApdq72P1Er6YhG/j2jksmBJpXjpNN+
	 fUHdQlyCFM+RE80y7luTqfkLYCDDKB+Crc96WPT8VorDug/DGTHFMMIqUu8VqluIfJ7tW
	 PiOZvB0dZAy84i6IrUOVmLEdQapl0Wz8kzlctieEcYa9INJ2uWxc4zeA2h8ZU3FkSk9ss
	 05AYhIMjCUWgk8PRRXx0G77XTowcHqyrimYKP+K2z2ekBrFuWvI4WH/7lN2sl1bD7FH2t
	 CbnGSWTHdNA3EQJJtDCOsgJ6StooUTVYCMMEukw+i3vTHFZjA3UgWAB7sjaXToy0wFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cc/eXwTIFGurxW6MQ0atsOag/KAy92EpaE6lGrlwnVU=;
	b=KDY3nJR/WfaQM4XdbqoMg2z4iSTLgBV1E1/QqqQ4OvjwxRlzeqeLIRmfyzVuFE4GDfMF
	 SUyMSrTH4uvhqvxEusiwuXT+K19TYN123J+pFhItGx5/EJqGfVEnvBkV22yjoFU3SSsOl
	 ah5Zqdtpgg+yzxMn4A6Qc0/dlfjb8gGPGhUX0YdlukJnyZHLWIIes4t13/50VyJbHi/fT
	 SIWGa3DpnjAmHBy3XAla19FTvVbQWP62x2yAjDcLrno5rysOXuqDFt6nUedQxm6jGSIIt
	 GBZX2ajGMkyw132P4fIG1YzV9i5Q7SG8k8I3evnhPAzvxAQYgUHVofZc44KVpLs5pRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B54poN+d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB4606D837
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B54poN+d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8321F0089F;
	Sat,  7 Nov 2026 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048627;
	bh=cc/eXwTIFGurxW6MQ0atsOag/KAy92EpaE6lGrlwnVU=;
	h=From:To:Cc:Subject:Date;
	b=B54poN+d/qXWy3Jv1EApfIEy0WZn3sft49TNwuf+RM0vPTLjwaLtQHfnlk4pTyRg6
	 DB1vYSe8Nr5KfwJla6AbSEPS+marw3nAx2R/ZhsD/OWm/qd+kp7L7jWW/tTLjE/WLs
	 DyO4gYrtb0/hTzmTbkfMaEwYvADPl4Ml5Dsp9WIY+0TehZTEK4MNYbK45hTOgRhRcr
	 C9DHnsZgxKkacoxs11nsv/lCoN/rsoiFbYtvWfIl8sqvXbpjo8b00ohOzVrjdUDvj/
	 FTWsTM3sN0boLlzj45mb/5CU9dFGiLz/La0YHDo9nQeZ4k60dIQH6cw35Vrr8jPYw2
	 KRydjW/ZM3GNQ==
From: Sasha Levin <sashal@kernel.org>
To: art.home@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:25 -0500
Message-ID: <20261107055025-failed-6.1-38cb2ef26b64@kernel.org>
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
git cherry-pick -x 38cb2ef26b6411277826da54c6bcf94523541058
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055025-failed-6.1-38cb2ef26b64@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 38cb2ef26b6411277826da54c6bcf94523541058 Mon Sep 17 00:00:00 2001
From: Art O Cathain <art.home@gmail.com>
Date: Fri, 16 Oct 2026 11:29:30 +0200
Subject: [PATCH] ASoC: amd: acp-config: force SoundWire probe on Dell 14S
 DS14265

The BIOS on the Dell 14S DS14265 (ACP PCI revision 0x72) reports
acp-audio-config-flag = FLAG_AMD_LEGACY_ONLY_DMIC. As a result
snd_pci_ps returns early and the SoundWire links are never scanned,
while the legacy snd_acp_pci driver probes the device, finds no
matching machine driver ("No matching ASoC machine driver found") and
no internal sound card is created. The CS42L45 headset codec on link 0
and the two CS35L63 speaker amplifiers on link 1 never enumerate.

Add a DMI entry for the model to the ACP70 ACPI flag override table so
the firmware-provided flag is overridden and snd_pci_ps probes instead.
Match on the product name rather than the board name, as the same
symptom has been reported on several boards of this model (09PVND,
0M0J65, 0C7F12).

Tested on a DS14265 (board 09PVND, BIOS 1.5.3) with Debian's 7.2.6
kernel, with and without this entry. With it, snd_pci_ps binds, both
SoundWire links come up, the CS42L45 and both CS35L63 enumerate, the
existing CS42L45 + 2x CS35L63 machine entry matches, the amplifiers
load their firmware and calibration, and the amd-soundwire card plays
through both the internal speakers and the headphone jack. Also
build-tested on asoc-next with W=1.

Developed with AI assistance. Claude read the ACP driver source,
identified the BIOS flag as the cause and the override table as the
fix, wrote the DMI entry and the out-of-tree test module, and drafted
this changelog. All hardware testing was done by the submitter, who
has reviewed the change, understands it and takes responsibility for
it.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Art O Cathain <art.home@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20261016-dell-14s-acp-v1-1-89b40d95720c@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 30e01bc47ee0c..2fb9789cac0ac 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -98,6 +98,13 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8EA2"),
 		},
 	},
+	{
+		/* Dell 14S DS14265 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell 14S DS14265"),
+		},
+	},
 	{}
 };
 
-- 
2.53.0




