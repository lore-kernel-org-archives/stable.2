Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011757;
	b=GyyTg6I7Eh2VZafY+cTPivxi6cCCoC51CxdliTq58jITl/VdZNeNtMn8RTKp0l0tLU+L
	 lcOt0+HlsBFrgUvSF+GrfX7vncOGW3xWSeGUu0n0gosw48K3gpHemrkVLtadrhs3EndQ8
	 kGxS6NPmSZp+TmtKhDpuM289VymL5Ai8mJyx0/MPUSVJm+6UCqzkla+fkMmXbwHt8YyVt
	 8pGb/xrCmhd7GfC37FHZjjNr3/W6asxe82r/COCdC67Mj119Y+rkjqT6WDPl9TMAIGTFp
	 OxLJ/InOj18j4hTxPiYO6c491ViAbUqRFd+ZJax+ff1+tDHUyf+BWJ3IVobAw7Qku8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011757;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=haqNkHmYUBM8afAHWDurlnqO/foJXidzEpjadaLQhdY=;
	b=USGqEafaaitfesoUlaUiWMVkus0eGSWM/NL0FucEDFEBHttLG9SeyxC1M0FO1a8MySEY
	 4S6OhkHq3y1sz3etmp0M6ZzuCz/dA9lze3rwCuAQDSU1kRmgWsCuHwooZW0PrOYPfDuIt
	 EEJXg6k1V+w3F+pdqCTxNeJPEz5wNZ9I3RacjKuvOS9NtIeCjPAtuMY3Z0wDyTlwW/+bf
	 As+4qcGcUdeI0tU+kFyiKlKsdYOIFhgFtmoWNYV4FgyWcoK0pRyB1yA7R4TzbUab96CY2
	 TzTjcCydgX4ELN30MSrXU1m69lUvJNrTL+kpT0MR1BvPmtiIvQQo9WJq97n7ebDuung==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eJNYHRwI;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A71606A31C;
	Wed, 18 Nov 2026 14:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=eJNYHRwI
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7972;
	Wed, 18 Nov 2026 22:22:30 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: s3c-fb: Fix potential registration corruption on probe failure
Date: Wed, 18 Nov 2026 22:22:29 +0800
Message-ID: <20261118-324f82bd41-fbdev-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa1ef09abc403a1kunmfc88f5031a12ca
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk9MVhgYSEkdTBlLTk5MQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=eJNYHRwIFeniVMid2Oy+In7DqyaRyzjNcRq4bw24gImwksylgJsGXjQdQKsCqNdyYzWh9d+Yl7k+WxqEglV4Bad/cMs33UCs2u2/zzdDQdTa/C21pXtSEz6rYaZdNNZ1ACYC4WQwwu+7kTvoaEy2rdQW14pgDzofId/GxuUq9IU=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=haqNkHmYUBM8afAHWDurlnqO/foJXidzEpjadaLQhdY=;
	h=date:mime-version:subject:message-id:from;

Probe failure cleanup calls unregister_framebuffer() even when the
window has not been registered. Its zero-initialized node can then
remove another framebuffer from registered_fb[0].

Track successful registration and only unregister those framebuffers.
Also skip empty window slots while unwinding a failed probe.

This issue was found by our static analysis tool under development.

Fixes: ec549a0fdc32 ("fb: add s3c-fb driver for newer Samsung SoC framebuffer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/video/fbdev/s3c-fb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 82a3bc9de433..c67ad47a49f0 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -161,6 +161,7 @@ struct s3c_fb_palette {
  * @pseudo_palette: For use in TRUECOLOUR modes for entries 0..15/
  * @index: The window number of this window.
  * @palette: The bitfields for changing r/g/b into a hardware palette entry.
+ * @registered: Whether the framebuffer was successfully registered.
  */
 struct s3c_fb_win {
 	struct s3c_fb_pd_win	*windata;
@@ -172,6 +173,7 @@ struct s3c_fb_win {
 	u32			*palette_buffer;
 	u32			 pseudo_palette[16];
 	unsigned int		 index;
+	bool			 registered;
 };
 
 /**
@@ -1142,14 +1144,15 @@ static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
 {
 	u32 data;
 
-	if (win->fbinfo) {
+	if (win && win->fbinfo) {
 		if (sfb->variant.has_shadowcon) {
 			data = readl(sfb->regs + SHADOWCON);
 			data &= ~SHADOWCON_CHx_ENABLE(win->index);
 			data &= ~SHADOWCON_CHx_LOCAL_ENABLE(win->index);
 			writel(data, sfb->regs + SHADOWCON);
 		}
-		unregister_framebuffer(win->fbinfo);
+		if (win->registered)
+			unregister_framebuffer(win->fbinfo);
 		if (win->fbinfo->cmap.len)
 			fb_dealloc_cmap(&win->fbinfo->cmap);
 		s3c_fb_free_memory(sfb, win);
@@ -1272,6 +1275,7 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 		return ret;
 	}
 
+	win->registered = true;
 	dev_info(sfb->dev, "window %d: fb %s\n", win_no, fbinfo->fix.id);
 
 	return 0;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

