Received: from outbound.st.icloud.com (st-2004e-snip4-11.eps.apple.com [57.103.78.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD273E51D4
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976524; cv=none; b=rSIMRYxWA0EDYbn3LdukWwKNyjnPp0gKv9GUfYvoBuFXkx/dGWaxpqga5AcAvzJysPjouoSsPsumaP9Z7eLuHCJGHESSgi9bRJepODLUvuV7fUwc+KkX6tqw0BNpXDXbk1x3NJFzr7yN8sbRjmZ/n7GVbX6RHW1KwaBvUfOARh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976524; c=relaxed/simple;
	bh=Oo8lIQfisTIBzfqkI5g3UMnfDWuX0NA/q0z0wGzPjk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjLf2VSbTRa939bHh9a4WGEIf/HYRl/wjO2dmMNMvfJQAeNOlphu5qOUYUgIbjtfI3labuqHRu5fVekITJ5cFr/F80nL8musbiypOk1Srxy6H2dveN5H67Wh+waDz0g6C9+g04VeL9FSYDWcC2rOeJLz/jef5ULPUaL9aEdG/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=VzjL+WHW; arc=none smtp.client-ip=57.103.78.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="VzjL+WHW"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id 61D1D180070A;
	Fri, 02 Oct 2026 21:28:38 +0000 (UTC)
X-ICL-RepId: 01a0fe84-e89c-78f2-85a0-2a3521161b67
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhKCkMFWhxBDUkdXA5bEhVdRVUXUhlHGFc4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgNCGRBWAVhWXQVNGlwYWQ8cA01WWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAtIAVsGWwJCC0kBVQRYHEkPTwdABkZUClwKRgVZK1sTVRdGCRkIXR0HWEcURw4PGVoUXBhT
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1790976522; x=1793568522; bh=aJsmC1mviHb37getbq+iRvVXVUnaonvh2KuAc9UpK0Q=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=VzjL+WHWzkmGeRW/57/513c8MRKJqjVXa0MvzylFzyk/YQm5Latbd7tRiSdvDCdN835RL1K7ad8hzTxtXuPJy7JvN1LONuoImOq9htmyJxML/9FKeeTmkK9IqbvyIPUlBISF8p3oCkSmo6Wrbc3O4Eja68GewsJ06c9Ls7uSiNzSr67mY96aBi4w7ezr/4M8vFqIKuqU9KjSWWz7J5G3COaeTQFWLtcql/HGbiMIhsCA2plKFoZERnq10e9h/lL/ZgFzezQs/fRUWQ/92UK/nLLA5mmwNXcRfR1nLvOIjRXXwZJGVJF3OxmyzCdkqlnvu9Vc/Idw0Pc8oagSKkddBw==
Received: from 252-PC-L.device.rit.edu (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id 3F1AE18007D1;
	Fri, 02 Oct 2026 21:28:37 +0000 (UTC)
From: Finn Zeruhn <fzeruhn@icloud.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Finn Zeruhn <fzeruhn@icloud.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/dp: keep MOT set between messages when no_zero_sized is set
Date: Fri,  2 Oct 2026 17:28:33 -0400
Message-ID: <20261002212833.9674-1-fzeruhn@icloud.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=U4KfzOru c=1 sm=1 tr=0 ts=6ac02207
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10
 a=UWokjQvqbcQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=tmjPn7o2apbUsHgEkIAA:9
X-Proofpoint-ORIG-GUID: Rk3qkKmZ0gbJTD9A2W_CcYbjnSmjo3j-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4NSBTYWx0ZWRfXzbmsrKE2psOA
 xup8hGPRrsgRj1iK+FU3T80jsfjf9FBXxBBclepIYFoQc91yW+eqhhaSUuJPhv66pSf9vx6GtLW
 q/BwF9ZShwI7GDLS9lOiZi8Ym+Zg55M5j3cyuNkhvrtmAq3OtVqBTvWldh5DhZImm+eL73Gpanf
 LQGix2chVlCqeS+TEPVORuPxATWeoqwRqPwhhK5/R+hPhEN8skDmw9ThWmng1cxwpM/VhHiCFD/
 J7hSfW8VS5EqHpakkRIQnBE5ZNfgGVknGZVrvERvzGPbSvom1dx7pNVHjNCtDqIeqBdWN2VZ/cf
 iP3hgeS4xu6FW+a9caqtXoybpZickU+ZP3csWhFwsLUSqHLc++JRL69Of2DVi4=
X-Proofpoint-GUID: Rk3qkKmZ0gbJTD9A2W_CcYbjnSmjo3j-
X-JNJ: AAAAAAABIX1DDu2r6CLCwNqrpo53j7UPSFCGV0xf2o7uDj4nKm+2DT0na4iiQnAkqlSq9p
 fd1oND7MDu/jefloDBNTXfT46NbSI3BbdjxIijySz6tblQaNxpAXjXbOdUd67NBHUSORx5
 caRIevSIRVV7Br585QQajTetwXgtPJokMMXGImmrG69Vi4aNgy7Bm9T4KDSK9T0EICj+EF
 4ocLEm979UtKHMyOg8xK25zYurszrfAcRhUiRwvaKz1ZuuBcvK8btWeYAu2+T5Hw3eh134
 oCToOZZc/bQIjSu0s9jfnZR4cpaj4FQYtTKNn4slL5s/TCGhokxJzD504m3n6GjW+rG3c+
 0reoln2gpes93hnLJAx++evdvYTJLx2p9TA/Kxo49zr8O5IzBUU/vLGImyk0XvXTD0TvVH
 29eM9iOh8CbYUc7m/VwSXduISjcUMlB3vprql7RpBZzjKvvAc5rQZRDgqrzwjmLzTt47pE
 4tjlryrUS9D7gYmLAFI2G+dYOxX8yMPLYxSQ3Y8nZ3bo2M66yVpQGqbpmHVBMUjae8eEMB
 1Y9JFbZcxVWLaw3eaKFEQ8JKbomHsHh6NQEqSiRKPq5Oxw19BfZJZ0eBsL2oRkN2k9HSpL
 JXBP7Xwyl2xha2o3UCdNqurTSWkoJfJkU8W9HviC2d5jdVNBb1kZxNzm3d+9ZKCskTFLRI
 KYQ8o5zJPwIXNzo8TL7AccuCkqvwH8QDkQTD+ClhsQVigP/zb5ezCj+S2hwonLxlwu1fHs
 9c0wf/xm1QaqkkJePWdA6aOXInwiBwfDjqESPWT6cX4xXLSxalrqI7isoQDKh5XyWYaRE8
 J1rWD9eb7LOxyaXgSeJFIuCn8JXtAOTg5rXHuIUVEAU5MtpqB07gqFQSuqKb9ymOEp5uj/
 6ivTBKncKIimPx8fR0a0zGyiqntvDDHjH+yNiO6AN8D9rBYdUT+2V0Eu+30UApjHrtslU5
 pTGyVzEe1vDSTbiwHzJgnq+W2AleEtdJBNaykqHcUnHjpS4uXH0BgNOuyRijRiNZSUOgqo
 mQL5FIpiiIXDDfCUaQiHeSJV4UsTBTGiV4ut8ZeN8vQ26zfJjEuK+ojJOI8pO38SK/g3Wg
 gzmHIZujVYhY5P4kVWtcKENCyJingqGkDrw6YkdT/76qWhPtroukH3cu8TvhL55R6aFD+w
 Pa2/YFeAfqU/vMdvhrIvOdaq2fleuQbAXaUVGbAB2l/PTNoBJir2kAskNruk816za6oLC9
 zZVoGcCrCrkElepvrHG7g+WuSlkSm3eCqJt1UWCg3Ay+fnHf7HvP/0rRYAgGuBuJj2JdXv
 9dGZQZyO9d4mlEHspPhwPd4OIm3tRH2H0dPhDFkCncndDhcU21thWu/3WAWZtjjPJ16g==
X-Apple-Category-Label: MTE1NzgzMjUxMzU6JGNhdGVnb3J5JF9QZXJzb25hbCw=

When aux->no_zero_sized is set, drm_dp_i2c_xfer() cannot use a bare
address packet to close the transaction, so it clears MOT on the last
data packet instead. The check only looks at the position within the
current i2c_msg, so MOT is cleared at the end of every message and each
one is terminated by an I2C stop.

This breaks E-DDC reads of EDID blocks 2 and up. Those are read as three
messages: a write of the segment pointer to 0x30, a write of the offset
to 0x50, and the read. The stop after the first message resets the
segment pointer, so the read returns segment 0 again.

On a Pimax Dream Air (three EDID blocks, native timings in a DisplayID
extension in block 2) connected to an RTX 5070 Ti with nouveau, block 2
reads back as a copy of block 0. The checksum is valid, so nothing is
reported, and the connector only offers fallback modes.

Clear MOT only on the last packet of the last message, as the commit
that added the option describes. With this, block 2 reads correctly and
the native 7104x3840 modes are listed for the Dream Air.

The same problem was pointed out by the Sashiko review of the patch that
sets no_zero_sized for all DisplayPort connectors in nouveau.

Fixes: f0ddbb1eed18 ("drm/dp: add option to disable zero sized address only transactions.")
Link: https://lore.kernel.org/all/20260827015758.0B4FB1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 488fd123a01a..7676285c19f8 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2192,7 +2192,8 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			msg.buffer = msgs[i].buf + j;
 			msg.size = min(transfer_size, msgs[i].len - j);
 
-			if (j + msg.size == msgs[i].len && aux->no_zero_sized)
+			if (aux->no_zero_sized && i == num - 1 &&
+			    j + msg.size == msgs[i].len)
 				msg.request &= ~DP_AUX_I2C_MOT;
 			err = drm_dp_i2c_drain_msg(aux, &msg);
 

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.56.0

