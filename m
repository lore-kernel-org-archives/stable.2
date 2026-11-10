Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326342;
	b=yskvkcW6sZUokLvtRaFouPq2GzHWYp1gFJEkvG87ULjIW7iEsAcjFPf3IhJWu6ulzjxE
	 qqIEwaHFvJpQXeFj4KA1JkMrnnG+wBzDO5x4/itdDIFSBWZobz+tiKYMgFpoGXtBVZVh8
	 9yQLR8vnyCVQJ2Zc9dJAuxSZV9KOCsDoSIOQlMXouqmss9zt3p5J6tJ+VThkW9B89zgt4
	 zmS/+JiPwy2zoF94+qlUYaDV6j2mFaZ91rNazBQa5zesXwJ/07LaRcoKPBxc/ByhLdfCu
	 ry8Qo1NlBRf6AlR8IkaTeYQzZvVc9MWQBZVtdOi9ZivzhlsiMlPq/WjFa6BUDQ4o43g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326342;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kIy38hcj4nPkLOkMSYPWcLJd07YQxs8gJ4UtpD2ILEw=;
	b=d+jHcRFKWyPrMVzCaKaZxJLrKliQ73MvCsfzxGwqeMvmSbg6K6izCnKlUzvD+vhY1FiQ
	 m0A50AsTCX1xKcqb7NVbqKLCFcbDR/79miedQHYz3RiJ85iYZM8dRXTzDt5oRDxZb9VTw
	 Mivwde3xxdKyIrSQaTLD7pH6J/qeLnBlEvJuyCX1OlyjSM8lx6CIX1flM57CRA/MH0mft
	 Bo8Orn0n1GazM3ErFjTFe71cwo+lm83s/I5RWX7xwt9X0z26wLxK+hqRFZcCFOF+lWwSt
	 H5JyJaUyV4Wdrpnj6//O4ILqeslmU+M/IjIc78IsJDcknnnoC13GOOIcnAewc1AoVgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHe1kpbh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D8606A33C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHe1kpbh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063AE1F00900;
	Tue, 10 Nov 2026 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326341;
	bh=kIy38hcj4nPkLOkMSYPWcLJd07YQxs8gJ4UtpD2ILEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QHe1kpbhls7qlzcc9D0yRFRxdgVP/xu362k/Jm/hV8vFWfLZ7t/ZBZsTye1QKGf7l
	 t1yrzJMDSYKEr/g+4gIjKZUUSsJ6zAk9nYmHWcjjghm+emodnv3eYbNTUGoPCuHku+
	 8BEEFmTY+EjqKEZDjoaLtjycn5ABREagpGN+r32NQwyCSwyXqEOInNAXcbmdZlHDV1
	 i5SXGeT/9zKxEc7NIIdyXovLC5wJdsP8l9XjGFrcgyGgD0yRL+GYNA5nYTTlf/aOyE
	 WscqGbL6Itn0R+ws7TUKnnNkuiKBS8Z12DbvDQ/w9nJ+vZ/1sFPB0zGYNsG83zVjMI
	 EkES/UUPivA2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
Date: Tue, 10 Nov 2026 10:58:59 -0500
Message-ID: <20261110155838.2379896-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060258-failed-5.15-b3e7ddd694f8@kernel.org>
References: <20261107060258-failed-5.15-b3e7ddd694f8@kernel.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit b3e7ddd694f8429217ba509b55b910a0e4361dfb ]

snd_hdmi_write_eld_info() parses a "sad_count N" line from the
root-writable ELD proc interface and assigns N directly to
e->sad_count with no upper bound, unlike the per-index "sadN_*" lines
a few lines below which are already bounded to ELD_MAX_SAD.

snd_hdmi_eld_update_pcm_info() later iterates
"for (i = 0; i < e->sad_count; i++)" over the fixed
e->sad[ELD_MAX_SAD] array, so an oversized sad_count read from the
proc file causes it to walk past the array.

Reject sad_count values above ELD_MAX_SAD, matching the existing
per-index guard.

Fixes: acb059938810 ("ALSA: hda - ELD proc interface write updates")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261008085133.9528-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: adapted to the older location of the HDMI ELD source file ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_eld.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 9e97443795f83..113c2081dda37 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -521,9 +521,11 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
 			e->aud_synch_delay = val;
 		else if (!strcmp(name, "speakers"))
 			e->spk_alloc = val;
-		else if (!strcmp(name, "sad_count"))
+		else if (!strcmp(name, "sad_count")) {
+			if (val > ELD_MAX_SAD)
+				continue;
 			e->sad_count = val;
-		else if (!strncmp(name, "sad", 3)) {
+		} else if (!strncmp(name, "sad", 3)) {
 			sname = name + 4;
 			n = name[3] - '0';
 			if (name[4] >= '0' && name[4] <= '9') {
-- 
2.53.0

