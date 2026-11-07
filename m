Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050382;
	b=n6d1U/xHcdYBCoM2TyQOASJiXARfulYXSD9SpXBQUKuoPruA+n1JdOmp9d96ZIOXeFdA
	 bRsEKU/iYs7xT0W9K2/AAYmROTUo0vMWaEKL76mBPKgcbZguzqTLNojNtLRiiLfMo0DpJ
	 GWJVZyX+q4UYzredjVaC/Q6mwk0cLOB30Or1C4Hnek7JmPL5wP+MlLUXhwe9dLylXwnHs
	 Yv8d/BTZrdoNhjWWXd6kzx+FP7MvR4XCJI5YPxeZUfrxoW1xK0r6PvjgDt/z1nAYdzNEe
	 TZp0VkGzohcujoTaKb/XclGuaXIYNnnP2KuZyv4B1Bd+motbI9TUMj7QJTOywB+TqGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050382;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o1rgsFLCljR0nmv6eyl1k8loUV0xn3MRq6k1Tj6kSt4=;
	b=ps5W2+40XNcDwdRKtFomKCZH6q4f1ngLt5DN4YB3vd3cIoxcc3NtMpDCWL57hrKuPBQd
	 DEvh8gWdR7NW9BNKcGEgonqCTLTnYk+76gRLmzNq0QNFTpgX7etifgCGv2CdZxieE95Qy
	 w6TZzIHC4nvMJUvMhtYB7ry4AajRILqOUw0+txOVzcuL63jPXGPZVVJapEURnzBORKcwM
	 P7WrqqZQoPAPvhFyAo6DLJFsDlK0XIth+fTmiNfsk+cspKTsOioTIDnXVqZ9QWW9+xNg2
	 ey2T10uF/MST3nECdajB9FJ0j+9Xudf3WGEvupJAjnspGFEEj/H4JhsicHgdk5U6ixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3gpLssv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F63606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3gpLssv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787051F0089F;
	Sat,  7 Nov 2026 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050381;
	bh=o1rgsFLCljR0nmv6eyl1k8loUV0xn3MRq6k1Tj6kSt4=;
	h=From:To:Cc:Subject:Date;
	b=Y3gpLssvAzoSiTfVKejzwCFXuCP284B28V+zO0ohZQom//ip9426oQgX5edioVvqd
	 Ow9hYLS+C9eix8alJ6qqlIv1ojw428oOC5o2NCHEBC3bINlTSFRWsF6NYdtyFiuRZe
	 SyFmhECMtPR/Nz5gjfoD7x0mqXoiTbxGy9LN3XEknJ04A2ns53ofxO9OcgyFPKb7nQ
	 4/BYo79EiXH7MKPMYQal0RzGa9tsKoVUYQ8wMmwf9ayBMdlqccLC7w8Z2KAzKFVw/Z
	 akmVkJM+xM3o/TPsBq0V5P1qTwkKNjL0WIdcLPI8B/Vl8sjNPWbZpathEd+mRp/hk+
	 bpOK/LhCxHm4g==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:19:40 -0500
Message-ID: <20261107061940-failed-5.10-6cf3ab38b0d5@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6cf3ab38b0d53d41f00fe594b2986849bdf994ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061940-failed-5.10-6cf3ab38b0d5@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6cf3ab38b0d53d41f00fe594b2986849bdf994ae Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Thu, 8 Oct 2026 11:51:22 +0300
Subject: [PATCH] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in
 hdmi_read_pin_conn

hdmi_add_cvt() stores each converter's NID into the fixed-size
spec->cvt_nids[] array (used only by the Intel Haswell pin-connection
fixup), but only when spec->num_cvts is still within
ARRAY_SIZE(cvt_nids); the num_cvts counter itself is incremented
unconditionally regardless of whether the store happened. A codec
that reports more converters than cvt_nids[] can hold therefore ends
up with num_cvts > ARRAY_SIZE(cvt_nids).

hdmi_read_pin_conn(), on the intel_hsw_fixup path, copies num_cvts
elements from cvt_nids[] with memcpy(), so once num_cvts exceeds the
array size this reads past cvt_nids[] and writes the resulting
garbage NIDs into per_pin->mux_nids[].

Clamp the copy length to the actual size of cvt_nids[] instead of
trusting num_cvts, which is also used unbounded as the size of the
separate, dynamically-sized spec->cvts array and must not be
truncated at the source.

Fixes: bce0d2a80e42 ("ALSA: hda - Allow unlimited pins and converters in patch_hdmi.c")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261008085122.9442-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/hdmi/hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index a8aac0b36c73f..355fd3e731836 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -983,7 +983,8 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	snd_hda_set_dev_select(codec, pin_nid, dev_id);
 
 	if (spec->intel_hsw_fixup) {
-		conns = spec->num_cvts;
+		/* spec->cvt_nids[] only has ARRAY_SIZE(spec->cvt_nids) slots */
+		conns = min_t(int, spec->num_cvts, ARRAY_SIZE(spec->cvt_nids));
 		memcpy(per_pin->mux_nids, spec->cvt_nids,
 		       sizeof(hda_nid_t) * conns);
 	} else {
-- 
2.53.0




