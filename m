Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18956246BD6;
	Sun, 28 Jun 2026 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618903; cv=none; b=uWgythBsyiilide1+njwtFW7/f/Yay9sxeir9ndg4QabA6yhZvaacKZFpFdywkFarG1RFJh20Pge+Mag8LV5EjPNKfguoVROeo3FI9Xdy4CtJbMCHmY9d/kZMSSeCqcqn2bP/pUNGj6XWUmUdPf96aJptLxj6YKAnxKkgMLOaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618903; c=relaxed/simple;
	bh=ZBWsD4DBFr8YBhC5UscRyxSTFoMhf1X4utlgF5zm6d4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EdkYkjjBgoAdxKXn9xBPM/skUd7qjojwlkvGPKs9DJHBUQj5RbXK257giE575b9/j65zaslYaNcplZzZqi4w8lczEhda38BDKKbVDNrBA1F/UAh/VWl24YEMiLI3+v0Bc+3H0EO9HsJ8HkPHl+yUn8inwm9Nw44tuorERzZyKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S2;
	Sun, 28 Jun 2026 11:54:51 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/display: drm_dp_mst_topology_mgr_set_mst: error
 path after DPCD   write failure leaks MST branch device reference
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626125117.37153-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:54:40 +0800
Cc: dmitry.baryshkov@oss.qualcomm.com,
 kees@kernel.org,
 liviu.dudau@arm.com,
 suraj.kandpal@intel.com,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74B9C429-5BBD-492D-B4D1-ABE168D68D14@iscas.ac.cn>
References: <20260626125117.37153-1-vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
 mripard@kernel.org,
 tzimmermann@suse.de,
 airlied@gmail.com,
 simona@ffwll.ch
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4DKw17WFWkKF4ftF4fXwb_yoW8Xw47pr
	W2kry2yr93JanFyr4UZF18WFWUKa9xAryrGF4UWw4fWw1UAr18Wa48tF1aqF17ArW2kr1f
	twsrCF18GF1qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9jb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7IU8Y2NJUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2pAixEZuAACse



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 20:51=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
>  drm_dp_mst_topology_get_mstb increments it to 2. When
>  drm_dp_dpcd_write_byte fails, out_unlock performs only one
>  drm_dp_mst_topology_put_mstb, leaving the other reference stored in
>  mgr->mst_primary. Since MST was not successfully enabled, no disable =
path
>  will clean it up.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in =
drm_dp_mst_topology_mgr_set_mst()")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c =
b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 8757972e8e24..db9441c80cd5 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3679,8 +3679,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct =
drm_dp_mst_topology_mgr *mgr, bool ms
> 					     DP_MST_EN |
> 					     DP_UP_REQ_EN |
> 					     DP_UPSTREAM_IS_SRC);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mgr->mst_primary =3D NULL;
> 			goto out_unlock;
> +		}
>=20
> 		/* Write reset payload */
> 		drm_dp_dpcd_clear_payload(mgr->aux);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

