Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045950;
	b=KFlhwf41GSSO2wX5b+XspUn7qqv+Yl6PqaRgO6bw6sGpFwXnEAVhRTGjhmlaJnUCL1wZ
	 HpEYukr0jLa1IEFj59ffT48IJr7chMLvXaqIK1mbXZ1WGwb1ff9QOhnojqfR6H8whrMaf
	 mOYBukK+/9m5AXqDKmJnC2eLOY+63+xQSyk6grWcPhUoPID8H6oocYi31De36qJKhxywn
	 Jjkbto32muQD4pfVJesKY9E6+rxq9xr8UBl1n+Ha3+J4lPICtblNEuFoRrbxzrpLRTZoy
	 ZEepqNZ+CRUSnwSaeywFcWLP1vHjx7Ewyagq1Uct6U7zwjeB8xcWp1gf51eRhYuzMag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mrpk6FqSIjysiIhfHJRG7tSTQFhLWU59C8n+ZRS/TpA=;
	b=lDWqh4Dx6pSmIHJeqC5zCXgUJ/lYoCsameYjYDMSaT7ggB8Zsh6+Aip3tONVZ+64Rlgu
	 GE+eGsOZVTMB9OIRQJbgdupSZI91TEaKxH0k578GI3vvqJY+B5FkV1d/wXPeQPCJ5K66C
	 yy2aqy74sbWF1vPFPrVzHHPe5rZZQ6XDEawcn9jYIns+a1uAcMvPLip/Ra/5tKZE7sQ/i
	 wvJLp8UKJzixthsqVacvvO41W3UiBqah/EKA/OaThCO7nU5tKpwfEJos/lcBZiujOrh9T
	 FS7vJl+Awbqo0r238IkqgeYlNWehKd39UEOtuU4Msr4p5/NBe7iVg82D8GW6SmW/DNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHf0y0jA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NHf0y0jA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F481F008A1;
	Sat,  7 Nov 2026 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045949;
	bh=mrpk6FqSIjysiIhfHJRG7tSTQFhLWU59C8n+ZRS/TpA=;
	h=From:To:Cc:Subject:Date;
	b=NHf0y0jAviVa970POtXLmhM8XJ1njFqUVg2yJ9Xc710MpzvIKCF3YHDCVQG438Cjy
	 EhrpL+5PTyxtP33wrPB78i1XfhRO5XxE0rAQ+dHvJBOhn/E+rN1EtM0hcnZDc2cbbY
	 Xww+Yn/YcIGAHtdqTlTJfq0FCWUYYkvFVL/9lUvp8DwCi+MNN0M67dhXyaWSAQGUfJ
	 cjU9PQOd1b75jy5mLEktbb4/boU3UWBtyHJ6mm5hYlRaIEXy7hVqlArZH95GBZUeu8
	 eGF83Gm9z35xDq9IhjcroAZ1S1HcP/Kpbq8phdWu5V0MsPGp1yDUFns4oS8hOH/cAo
	 aQpUs4njtjepA==
From: Sasha Levin <sashal@kernel.org>
To: srinivas.kandagatla@oss.qualcomm.com,
	ckeepax@opensource.cirrus.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend failure" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:48 -0500
Message-ID: <20261107050548-failed-7.3-d34a818a331f@kernel.org>
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
git cherry-pick -x d34a818a331f7e270fa9dc3db3d96f6a0d4fa7ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050548-failed-7.3-d34a818a331f@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d34a818a331f7e270fa9dc3db3d96f6a0d4fa7ab Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 08:38:53 +0100
Subject: [PATCH] ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend failure

The SoundWire IRQ was disabled before pm_runtime_force_suspend() but
never re-enabled when the force suspend failed, leaving the codec
unable to receive interrupts.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20261020073856.1177749-4-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sdca/sdca_class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index ca311209c6d11..ee61c983dc574 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -265,6 +265,7 @@ int sdca_class_system_suspend(struct sdca_class_drv *drv)
 	ret = pm_runtime_force_suspend(drv->dev);
 	if (ret) {
 		dev_err(drv->dev, "failed to force suspend: %d\n", ret);
+		enable_irq(drv->sdw->irq);
 		return ret;
 	}
 
-- 
2.53.0




