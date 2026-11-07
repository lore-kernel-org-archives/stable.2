Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047011;
	b=Wx6nyL98gjnctjw8nRqFEFbrFWei2/qKJ+XY1H/tVPA3XZDC/Uf5QYzSkrQvUkGmqm8W
	 R3DKEQFpbejcYd54BZiZoUaSOCrddKoQer+hsrYJxi63rgqWicp0Q/VV0RR0QhjfFsqqM
	 61O39gcUxYek0SKtxTRNGzT6ybDA0ogsdfctM2WcugsEm0HVVwAT5KPgiamlJ/HdNN2bv
	 424fqsAw6O/zgBOcwOIE08rPZuljBnYvonVC0MLi1C5eTZwSOkT2veAOwY7g9wP1Yv+jY
	 yfjgD82b9tfh446PyHdwf/g6jSlEiB4elZKUxmLB2PS69ojtLDql2vMO6gromOZC+PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fSLBZkrzhddw43MbrVHsJn73OixIuZW3w/yDKkFSC/w=;
	b=AgDGUQfxI2jYS87G7a2SpLfWcLTmY0plq0EgTUQxz3qpjuPP9uM4p/lijpBu0xpQrbmh
	 ylMKv28w5J0McpevjH+AmFnPgMYsJuVojiuhHYkBAG2ewh8NpAJE8C8mN1RF1TjtNz5Bk
	 RrGNfQXDf//kcjoG6Har93Gz+WDFaTnL1s32LMEVSw795TGNZ/y+5JXlfWraVNaY5dzA7
	 RzOL5CsZttPbyA+YKA1OL/J9ooWNyJNt8siYxsHH8VG8vn2JW7WYY5GN/bi0A2MdWCRwC
	 ZkFR3kBJ0tsn/ngIzJAGaomeIGG6wxPmQ79lWc7uCg6tsSpD8gNFbIMQvtlv+VMVy/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKrPwVb4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6E606A339
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKrPwVb4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6821F0089F;
	Sat,  7 Nov 2026 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047011;
	bh=fSLBZkrzhddw43MbrVHsJn73OixIuZW3w/yDKkFSC/w=;
	h=From:To:Cc:Subject:Date;
	b=AKrPwVb4NXP2XbCROMbOYpLDEZLGuiqLXR7FKJ1tIyR6oLfpLocve5Pxu64tYBfyU
	 hrA+9PmLTrt/vswYqq2w62Y+GA0rX3a33DzpZciSoWMj1Mle/CFbbMjFOJYhYqe+vo
	 Gfvld4onbJHouUA247BdbhUWosm/97kMlNhYCIgfLJvi4ySPjx5V+rSSOvQLRqABnx
	 B16ztko+s0XT205bbKt8FQ7xb5L1o16eR/SEpWdNyJtftxRcM9xUPX3DgTCZoTg260
	 ijCq+CEJrpC7z9FyXjnwxfC4aUmnwZ2Q8qGnAPr9I7Ib0Hi+kSlZ8blurS7hHEWJ3w
	 z9ceQeoTBCN7Q==
From: Sasha Levin <sashal@kernel.org>
To: art.home@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:29 -0500
Message-ID: <20261107052329-failed-6.12-38cb2ef26b64@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 38cb2ef26b6411277826da54c6bcf94523541058
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052329-failed-6.12-38cb2ef26b64@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




