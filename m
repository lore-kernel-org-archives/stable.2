Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795364661;
	b=PRfKl5+0TAQdeVLqAR23zM34xTIgwUu2bO4zWUbaMkQlAGhJupzXboXtPgjaUVMnPMnb
	 DNPJIUaduzk2GNCp4RXiGjgroyiRekaJt/j/Kn0Oi6gJ1UTans1cEF2UgPWq4mJAzuZUx
	 SYgJLQmF6p1ItikGLWX0XElkOmlUf0DHPbNAH42D9o2TxoivfroC3Dcah/XRnuiZetzDk
	 dBv3mE+40TRwNTEYEQA+jrNQVKdggW/07pSxqyp+EaWGFxwhqjatuxt/Okx3mJyfkshrC
	 DKhh0G7Ob3kxvGtq3k9m1pv2B/HrqTqi/F7OxUpE7XfxsHaV7YbZSBwNR4TNFyCO7IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n2HnkONyAz5OvBrfYtDwxSrIOzDjXMJX31dQPz9Vcto=;
	b=gaUnp1DpO1a4neF5qAE7vgfvgdKbTajo0+d2d6G0f6Ys8xjgvDwwXXdo7h3WUyYDbpFj
	 IQHitRC6CNfPCK9P0MgPxR8auaYVh0cdny79get+5BZ8wkf5gQhkFGgZlgmHd7qAQ33ed
	 Pxqk6YjSnC1bY87p4mJZUNGqF0qKkGAV2Pxd8MAD4AbKcPz2QtruZlPXGn854w28uZBv9
	 qQKbm8VMbvTRcROOS0UXJp7Sb2QV3WaszCaPGKXK34Y6bxeya8+mu+k8DBmwN6xsgSC9D
	 yhbRYVbKW2rWDpCSk4+YxMqefU6LsG8Zj5W/O0fTBAy+myn3IKTpLYwszOJCxNqAvBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afX3YfcW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A84606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A84606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afX3YfcW
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ece3ab2e91so814985e0c.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 08:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795364660; cv=none;
        d=google.com; s=arc-20260327;
        b=lxiuHw8Q9aaYnA4B9Ve+34VkTqqkc+c6w9U12zFMGO4lI/5tma9iXV15qmdNn28D7q
         PFq//bx4AZP5WS0hm48P0u2PTIfk8+IrUXT6iuBH4DfbGVlfaeUTf+wv0wULx6CgbpRz
         PXy9vMrmH0woApd03pM2UKiAXHV6m0LbpamvLvGwzjNsuL0QWnjmQybxbpMNE8Nrjzb4
         G1O0VzIDdkqFLz+6Z2oHN/dl6MKwciwqKsfZc0YNW9olkj4KX42k6U5P63AkdDpBB+Ek
         kPPdofyufxZr1MbuxpbEr+hP7nhP42V5gPp97KceYD74WPqsIJbFqUx8H1fnuLJ4eMZf
         e79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n2HnkONyAz5OvBrfYtDwxSrIOzDjXMJX31dQPz9Vcto=;
        fh=mRLhnanSZwiclWkpfNXEoUWGy2STeKQ+t2ZAacJVA2Y=;
        b=Mcm19/30kkpZh5c7/9Z/5k/5i6w5bXHifrkCz2Gi3j8832DQBH+F2A54joeHmwuBx8
         NVGeElBTOo3QY9i/zn76pPGB1z8atetDytqzfRCnDdgqYhemCkAdNAankDGfeNB0dOx2
         +H/6GpXQEm/iZf7wLWTdYGLRtUSjWAfYr/+9r8eOmX7yiYkrwT2exLoCJwoV0+FI4Spm
         +pqJqZbksuFTatHtWVXD/Mek2/TsX23zsw2j+kXWLO9OrchSliBO3KudWhHZAMAv0Hox
         Nc/ecORvhJUO2RXS6FvF0xXlRzzbqiMbBNKg4BmCPnEob/5tPfwbHY5IHPGhCRDy8H9a
         ESMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795364660; x=1795969460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2HnkONyAz5OvBrfYtDwxSrIOzDjXMJX31dQPz9Vcto=;
        b=afX3YfcW9NAzIVyC17QRC5kSiBGMdB/4Q4CF6WclhBWSrQ7USro/hLjvmTBwqJ8X9A
         wBnkU23S0DP0LEmfDyXe/p2K8oc+v/dL7oH63JVMm2TD5mGHkyuMQ+9CBG4HSsvQcCD6
         t9cd+KtsJD3zpbmFE+MLhXIFqkHOGYVCuKKNBjOl6mhG8BBdY0r7UyU9elfO+a6zskxW
         IAUrJliC/Nxh05CJ2iettyCY0+urMoxTIThz8fpDGCcc/RpVyYYuy3tj6prE4lcyhrtC
         fXm9VNtpGBxIxxTerTC7onuMSQgqid7onNV6aDvNSocDYIZIwlNfA7L1UhZpW8U6Bt4m
         nQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795364660; x=1795969460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2HnkONyAz5OvBrfYtDwxSrIOzDjXMJX31dQPz9Vcto=;
        b=dWXzzhVQDuV6jAWtuyTcIakoMosuvPGX3zsyIZ8SCk5WkWq+INYnHJ1+YMBJLDmWRk
         GCs092FSqAYPnzeCMUpUWMzslDnl8Dfs5IpXReupnJtOfo0O2ub9HkjV2lCCTiwFa4WS
         bq1ZcZ05/OmZbspwIX508iNaOptdVjKCvJTvxtW90b0uGAGDomHCEGByG3k3sBSR7TYT
         06HjBXMX8nVxvBidnmgW5Cuu0jukk9D3njHAjLj86Q6MlELp6mcKNKOEi05zokTbU4vK
         yvhnYljA8xPiPlxK3W7ePruT6eyJEKbskpn1Wlp2sHHm0aHICk8kFltJ6A7c3lb+kkCf
         rQKg==
X-Forwarded-Encrypted: i=1; AL+hErECYRikb+/1ZOYhxbMH+6F6PLr+yS08sNtAHJE+DE5H6oM81gHEwmFHYKx90tRoN28QzTLkIVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BiikkyZrqORJK/5Vf4XcGuc3Q7n8Cs6MdanCEeBvpuyAp0Gcx
	6UYUQRaH4SfscedcWh/ImeYD9zpOxrutY/3QIBDuVnrCYu7klgLxnCUnpm6cM+Jii5QoDI4nd8b
	gGr1BhcOYDqE5hAmibY1hBtwwjugvEjU=
X-Gm-Gg: AZFdTZegDdbyAR2lbzwrw6Xi/zifwHsH7vG+HEVE4BqYx/A47HUiZ2M1D51R/sURjEJ
	YC+HlHkxzYe4e5YkWH7MBsBRrUCCrbUfo0u+01hihDP6tovEIHwV7NaZYdqI71+Tbe+1FxS9bwD
	JleHYFDCa5NY2yZAFm+0Z3jq6BzrZj3zTJVjeyB9nXdjBum8FPcCUjcJWvVAWOo9u975Mthxmck
	7hBYpBLEYs479MJ/LkL0WzN/IlTZdHg0a+vT6ibfYNsUAR0PXxRMRCnb4beb+GZ09EP9sX1Dsy5
	ITGsprc5NmbkO2HbWu+wQPYf76eMCtADJroskTtnYgGvNtfBb/Cf26YYMbfjGx9RQ6JxqRr76o6
	Wy5V4/Wz59vvFjpiwV+Wjj1hcqnNj4boqE//EHsP+SyyZGt5Qv64S8ya9AG+bpx0Z
X-Received: by 2002:a05:6122:29cd:b0:5ec:d751:a18e with SMTP id
 71dfb90a1353d-5ee8af5d5c6mr4139590e0c.19.1795364660204; Sun, 22 Nov 2026
 08:24:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122045841.99012-1-fredric.cover.lkernel@gmail.com> <202611221905.fQpuvetd-lkp@intel.com>
In-Reply-To: <202611221905.fQpuvetd-lkp@intel.com>
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
Date: Sun, 22 Nov 2026 08:24:49 -0800
X-Gm-Features: Aa3M54pLCK7XgGyFOtsNWn7B-0IlzQDmNjwu1YO12B2eu424c3ONrYetGFn3o_M
Message-ID: <CAAk_H6H8SZaa6xsKmyViYMwCe+-Z2xaftVjT0zrW_B-PJjvumw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: convert DFS target node name from cache
 charset on mount
To: kernel test robot <lkp@intel.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, ChenXiaoSong <chenxiaosong@chenxiaosong.com>, 
	Tom Talpey <tom@talpey.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paulo and list,
Please ignore these build errors. They are due to the dependency on my othe=
r
patch. If you would like, I can put them both in a series to avoid
errors like this.

Thanks,
Fredric

On Sun, Nov 22, 2026 at 3:51=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Fredric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on manguebit/cifs-next]
> [also build test ERROR on manguebit/cifs-fixes linus/master v7.4-rc3 next=
-20261120]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Fredric-Cover/smb-=
client-convert-DFS-target-node-name-from-cache-charset-on-mount/20261122-04=
5840
> base:   https://git.manguebit.org/linux.git cifs-next
> patch link:    https://lore.kernel.org/r/20261122045841.99012-1-fredric.c=
over.lkernel%40gmail.com
> patch subject: [PATCH] smb: client: convert DFS target node name from cac=
he charset on mount
> config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261122=
/202611221905.fQpuvetd-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20261122/202611221905.fQpuvetd-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611221905.fQpuvetd-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    fs/smb/client/dfs.c: In function 'dfs_parse_target_referral':
> >> fs/smb/client/dfs.c:44:21: error: implicit declaration of function 'df=
s_cache_local_path'; did you mean 'dfs_cache_canonical_path'? [-Wimplicit-f=
unction-declaration]
>       44 |         node_name =3D dfs_cache_local_path(ref->node_name, ctx=
->local_nls);
>          |                     ^~~~~~~~~~~~~~~~~~~~
>          |                     dfs_cache_canonical_path
> >> fs/smb/client/dfs.c:44:19: error: assignment to 'char *' from 'int' ma=
kes pointer from integer without a cast [-Wint-conversion]
>       44 |         node_name =3D dfs_cache_local_path(ref->node_name, ctx=
->local_nls);
>          |                   ^
>
>
> vim +44 fs/smb/client/dfs.c
>
>     13
>     14  /**
>     15   * dfs_parse_target_referral - set fs context for dfs target refe=
rral
>     16   *
>     17   * @full_path: full path in UNC format.
>     18   * @ref: dfs referral pointer.
>     19   * @ctx: smb3 fs context pointer.
>     20   *
>     21   * Return zero if dfs referral was parsed correctly, otherwise no=
n-zero.
>     22   */
>     23  int dfs_parse_target_referral(const char *full_path, const struct=
 dfs_info3_param *ref,
>     24                                struct smb3_fs_context *ctx)
>     25  {
>     26          int rc;
>     27          const char *prepath =3D NULL;
>     28          char *node_name =3D NULL;
>     29          char *path;
>     30
>     31          if (!full_path || !*full_path || !ref || !ctx)
>     32                  return -EINVAL;
>     33
>     34          if (WARN_ON_ONCE(!ref->node_name || ref->path_consumed < =
0))
>     35                  return -EINVAL;
>     36
>     37          if ((size_t)ref->path_consumed < strlen(full_path)) {
>     38                  prepath =3D full_path + ref->path_consumed;
>     39                  /* skip initial delimiter */
>     40                  if (*prepath =3D=3D '/' || *prepath =3D=3D '\\')
>     41                          prepath++;
>     42          }
>     43
>   > 44          node_name =3D dfs_cache_local_path(ref->node_name, ctx->l=
ocal_nls);
>     45          if (IS_ERR(node_name))
>     46                  return PTR_ERR(node_name);
>     47
>     48          path =3D cifs_build_devname(node_name, prepath);
>     49          kfree(node_name);
>     50          if (IS_ERR(path))
>     51                  return PTR_ERR(path);
>     52
>     53          rc =3D smb3_parse_devname(path, ctx);
>     54          if (rc)
>     55                  goto out;
>     56
>     57          rc =3D dns_resolve_unc(DFS_DOM(ctx), path,
>     58                               (struct sockaddr *)&ctx->dstaddr);
>     59  out:
>     60          kfree(path);
>     61          return rc;
>     62  }
>     63
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
