Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794428710;
	b=rr9yBddcnvfODS/+/pQhz/4pCC9g4tgTAZXzUmonye1R+qLi+NQkOTxdLg6XLB2M4ISd
	 HWxppHx5Va31fHHCy1eIj+IymZIANq/IsnYbvTCcNEJ47PGjW96/RVSMtQWWVOrzryPGK
	 80ojQUungYFr1U8/mka0jBV2xzWIArfAccavIVHkLfmIDWTYn25R4qzXgxiYB7TDhOnwh
	 X6RXr3pRlr8mnfLlWkhaZrIJiY7iyDRmYTc/lFcRLVRH6aFMZl1LErsznR5fH7pvHwMT3
	 QZlYOqNMllDCGrR89XqLK44GaZZqJiBM5Y7YO4fqnssAKE8tktiXhDY1JCdoZNXxhuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428710;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eyPtou3mnNUtK4XdibRlCeShaANokPxgCZPvXYB2rkg=;
	b=mTOW6oumbffFr0tE4tq8kgXJkBA388PBT9OBZdC6e8hwHXoP4YwAMQ/pE6HF44DlVD2v
	 CuNUI33AuRyz/qjIqUM+RG0afgdwnPLgD9GcRd/5ZVgYGCjqp58sDmhN4VG09wvfxPuKi
	 BmCjPX4xZWFWN5vd/oUXpTHQhwmXEO4tQz59yGfQfBFBIiBhpbqhgtHD3r1YdRu7rXGex
	 qKicPVVoWrVXpSFKFhvXLkchX7W+pmWi/x0VgwM6RV4GU7hcGXSNWgj8BURON9O6NsI/U
	 jNKVqAiEnnfzwRRZNkD0fj6wVjnuNszHYmY9/hmy6YsxJAj2oGLI4LY8F1iuizt/3EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCKrFKAG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178AA606A324;
	Wed, 11 Nov 2026 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCKrFKAG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794428709;
	b=c+Wh0XqXE4haoVTHfaiaQoY4S4KikxO4uaDKs4gJNmTRGXg4t/4idMlwT9p1Swjx4jDL
	 CKFOVgWRAt/uup0pELbtHnFC5heK9OhF6bmAr8ZTJ/AxHCYgRPN4gedWMGCkeU0I4Y4cN
	 XOLiXiq2VW20JOTnXO9afWxdg8VBCY+JpgUgFivL0nWNSwO9MyCYX/EOWVOvuTxTZOtwB
	 J4AjeyLqmpMVeGk+dn7X4EixxTUXkSebk8ls4m6fu/3aOe2vVJJnY6BA2U6ZSZe6x0k6M
	 ceP+mLEIqu61Kxt9R9uKNGK39jcpqNaTD0zWko8NFXtYpUIJUAl6+Cd0Jc9cyS+5yiQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794428709;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eyPtou3mnNUtK4XdibRlCeShaANokPxgCZPvXYB2rkg=;
	b=YHWSXXzA7YWCC9JcOCFIZ9KPJ4RfEzI3ERaSnfaJCQ8qgfyt7gmcAZX0YQ+Tg4WxT3qW
	 /4PqZmJqvGRyr8EZYkBTu5755BYL8glNNaumjbXoiQ6c3nZVlKRLpKHznzRZY7vl6FjfN
	 X7cNVCuHMgXa1tCVVGsnqNahCe0kc4tQkdpXO8yau5WlJ12lu0GZJ7/UhtxGcEFTa/cpb
	 hYaeqkYVEM2B0Q8yAdYXxOInt7puyjUhF5Vq7fypjc/HF0EuFnES+4SkAjY+f0zY15Zig
	 8iQCm8EqBj3bUSTLBGJaOP10uQMShFrc5t+QtZ/CFDn+rWeI7rBQxUCxSo7LlGiSmHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 561CF1F00A05;
	Wed, 11 Nov 2026 20:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428709;
	bh=eyPtou3mnNUtK4XdibRlCeShaANokPxgCZPvXYB2rkg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=XCKrFKAG8iW6nUVrqi9se0OUNL+CGC1/3Izt6KsrY5oOD757MZeI4ZCS/5/GpWrgj
	 KvEjT7+n0iRORMNjXv1CwQqX+cZzFKmmedQlorYRrMuwVHuq6ymYKiJOlBOQ2O3hA9
	 Lhi6WGqvsBoA/RJw8M87ITGMAXtBD/ctlTkzh+3gGOKbPYos9ZMxBwsAZVjIRDKdsd
	 +vBPcDSvzoc9muoco7Lan8QRZN58Y/SGd/xP9mWNMkddE0Z0sjqe1Dt7WEBKcY8Ajk
	 EerBhrL1JbDbdi7XvclQBeh28Trxv25AzCFSU9RiJ8MI4EjTzcmc97t59bRozdAKaC
	 4+XBz7KyQ2dOw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A6A20490EA;
	Wed, 11 Nov 2026 20:25:08 +0000 (UTC)
From: Alban Munari via B4 Relay <devnull+alban.kernel.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 20:24:48 +0000
Subject: [PATCH] ALSA: hda: cs35l41: Fix hibernation deadlock with the
 firmware reload
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-cs35l41-freezable-fw-load-v1-1-ebcaf549b2f7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBCF4Vchs3YSW8DbqxgW7XSqYxowHUED4
 d2penbf4vwLKGdhhUu1QOZJVIa+wOwqoLvrb4wSisHu7cGUIWndpsZgzMyz84kxvjENLiCd28Z
 SPPngjlD+z8xRPr/2tftbR/9gen2DsK4bNq2gkn0AAAA=
X-Change-ID: 20261111-cs35l41-freezable-fw-load-c9542cf8bda7
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alban Munari <alban.kernel@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794428707; l=3724;
 i=alban.kernel@gmail.com; s=hephaestus; h=from:subject:message-id;
 bh=IXzrGoSena48kpecVx+KFjQckzRH8kQoM0LZy+B5cYI=;
 b=E5phtmV4Gn6aVvUFA1LPzfdPdrfTyxdtNb1tewiRSAM7gAMZoN6x9nLViSuPmIycTBlW6fX24
 CbOSxRcbkjoDPIc+y3A/0AyHUAkvqEX9YXllN36Fv3zd/1vHTr0wrow
X-Developer-Key: i=alban.kernel@gmail.com; a=ed25519;
 pk=E4gTLxHRk8yuKicoDcjhUfRHnlctgbnlV9dmOwM5338=
X-Endpoint-Received: by B4 Relay for alban.kernel@gmail.com/hephaestus with
 auth_id=1455
X-Original-From: Alban Munari <alban.kernel@gmail.com>
Reply-To: alban.kernel@gmail.com
Content-Transfer-Encoding: 7bit

From: Alban Munari <alban.kernel@gmail.com>

cs35l41_system_resume() is also the .thaw and .restore callback, and it
schedules fw_load_work on system_wq. During hibernation, .thaw runs
right after the snapshot is created, while tasks and freezable
workqueues stay frozen until the system powers off. The work calls
request_firmware() with fw_mutex held. When the firmware files are not
cached, the lookup waits for filesystem I/O whose completion runs on a
freezable workqueue (btrfs completes reads on its endio workqueues,
which are WQ_FREEZABLE), so it never returns. The next step of
hibernation then waits for fw_mutex in cs35l41_system_suspend_prep(),
and the machine stays on after the image has been written.

Blocked tasks on an ASUS ROG Strix G17 (G713PI) after the image was
saved, from SysRq-W:

  task:systemd-sleep state:D
   __mutex_lock.constprop.0
   cs35l41_system_suspend_prep [snd_hda_scodec_cs35l41]
   dpm_prepare
   dpm_suspend_start
   hibernation_platform_enter
   hibernate.cold

  task:kworker/15:2 state:D
  Workqueue: events cs35l41_fw_load_work [snd_hda_scodec_cs35l41]
   bit_wait_io
   read_extent_buffer_pages [btrfs]
   btrfs_lookup [btrfs]
   path_openat
   kernel_read_file_from_path_initns
   fw_get_filesystem_firmware
   _request_firmware
   cs35l41_request_firmware_file [snd_hda_scodec_cs35l41]
   cs35l41_smart_amp [snd_hda_scodec_cs35l41]
   cs35l41_fw_load_work [snd_hda_scodec_cs35l41]

Queue the work on system_freezable_wq. After .thaw it then stays
pending until the system powers off, and on resume it runs once tasks
are thawed and the firmware files can be read.

Fixes: 88672826e2a4 ("ALSA: hda: cs35l41: Support System Suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Alban Munari <alban.kernel@gmail.com>
---
Testing: ASUS ROG Strix G17 (G713PI), two CS35L41 amplifiers (CSC3551),
7.2.14-zen1 with this change applied. Before it, every hibernation since
2026-11-02 left the machine on after writing the image; with it, three
hibernations powered off, on mains and on battery, and both amplifiers
reloaded their firmware about one second after tasks restarted. Without
the change, setting "L0 DSP1 Firmware Load" and "R0 DSP1 Firmware Load"
to off before hibernating also avoided the hang. On sound/for-next the
change was build-tested only.

AI assistance: the fix was developed in an interactive session with
Claude Code (Claude Opus 5.5, Anthropic). The model read the journals
and the kernel source, proposed hypotheses and experiments, decoded the
pm_trace value and the pstore records, and wrote the change, the
changelog and these notes. I directed the investigation with a
troubleshooting procedure I wrote for the assistant (research before
experiments, one variable per test), supplied the observations, ran
every experiment on the machine, reviewed the change and tested it as
described above.
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index 6fbc194d3347..efe937d18330 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1012,7 +1012,7 @@ static int cs35l41_system_resume(struct device *dev)
 
 	if (cs35l41->request_fw_load && !cs35l41->fw_request_ongoing) {
 		cs35l41->fw_request_ongoing = true;
-		schedule_work(&cs35l41->fw_load_work);
+		queue_work(system_freezable_wq, &cs35l41->fw_load_work);
 	}
 
 	return ret;

---
base-commit: 291d8707fa439ed4ec72552e7770177f6b6514e4
change-id: 20261111-cs35l41-freezable-fw-load-c9542cf8bda7

Best regards,
--  
Alban Munari <alban.kernel@gmail.com>


