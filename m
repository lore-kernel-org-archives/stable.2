Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC372E091E;
	Tue,  9 Jun 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995769; cv=none; b=kLDuuWmapMcqAujoHovQHDe528HZCnXwD7PT2kPpWMAEhgkltGH2TaSLiOLKGTEY3gg9ONUHnnWW+3BnJ/ykc8ty/IARdkyisnjkdW0gCObfsWXSWg8Pzh5bd9hGVlV76IIR6eDGMuskF2Tx5HkAxJ/sP6BT7SrL4/2XuqH9y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995769; c=relaxed/simple;
	bh=UmkP/nL3r38JTITNDMoUIrL43Ud/mv8TE/EbWihEuGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOOJdmGslESn9OSvm1R3n/VhoS3gXQ8dc6FZIO9KyBhm2WbkNSo2oO/nA13MiS+WxL5osGA7Tp/gvOD2Of6VoIDZNMwXkJvTyDmRxBGlmGccuHSnMxzGfp2QOy/FjoB7SFkcjV9H0609k1aKudGlTk3nuUyIewSHqn6OAkust6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=AD7+HCMt; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="AD7+HCMt"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41a876c6e;
	Tue, 9 Jun 2026 16:57:26 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: ttabi@nvidia.com
Cc: dakr@kernel.org,
	dawei.feng@seu.edu.cn,
	dri-devel@lists.freedesktop.org,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	namcao@linutronix.de,
	nouveau@lists.freedesktop.org,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Date: Tue,  9 Jun 2026 16:57:29 +0800
Message-Id: <20260609085729.3786763-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
References: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eab99d60503a2kunmd4cb5e84127d3d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEtCVk4YSklJSh9MHh1JGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=AD7+HCMty0xT7ukJ2iVq24XZZtBk3S/QiDWX6gpGVFjcPKiO7RmZE7dzKCP/i1ObA/sHrur+vKJnntauTebn7UK4kaZhgSBnpvDaCOC3pG1hOrsw5Ok03Ux6gPVAd2HoLcW8JJIC4/n1uvVMkY4LrxLMkFVDeukP++uXZW+UT0U=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PWKiJfHLAuY51AfkQhZeCWOGsOm5BCLCBnZ0+m/OIxk=;
	h=date:mime-version:subject:message-id:from;

Hi, Timur,

On Fri, Jun 05, 2026 at 06:22:41PM +0000, Timur Tabi wrote:
> Ah yes, you're right.
>
> So now I think a better fix might be to have two different `blob`
> variables, so that there is no longer any confusion. Because right now,
> the nvkm_firmware_put() call at the end of the function releases a
> different `blob` depending on whether `bl` is NULL or not.
>
> What do you think about this:
>
>     nvkm_firmware_put(blob);
>     if (bl) {
>             const struct firmware *blob_bl;
>
>             ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
>             if (ret)
>                     goto done;
>             ...
>             nvkm_firmware_put(blob_bl);
>             if (!fw->boot)
>                     ret = -ENOMEM;
>     } else {
>             fw->boot_addr = fw->nmem_base;
>     }
>
> done:
>     if (ret)
>             nvkm_falcon_fw_dtor(fw);
>
>     return ret;

Yes, using a separate pointer `blob_bl` for the bootloader firmware is a
cleaner approach. 

However, we must keep the final nvkm_firmware_put(blob) under the done
label. Moving it earlier would cause memory leaks in prior error paths
like nvkm_falcon_fw_ctor(), which jump directly to done. 

A safer approach is to manage blob_bl locally inside the if (bl) block,
while leaving the original blob cleanup at the end. 

What do you think about this:

        if (bl) {
                const struct firmware *blob_bl;

                ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
                if (ret)
                        goto done;

                ...
                nvkm_firmware_put(blob_bl);
                if (!fw->boot)
                        ret = -ENOMEM;
        } else {
                fw->boot_addr = fw->nmem_base;
        }

done:
        if (ret)
                nvkm_falcon_fw_dtor(fw);

        nvkm_firmware_put(blob);
        return ret;

Regards,
Dawei
