Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75732B135;
	Sun, 16 Aug 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786870909; cv=pass; b=HLiReuo1NJuz4knNXLm/dsx8bAKPHY+owL0wL2uOE2/2M4qDTM/JyHPySLTNkh/HmJgcMTu+mvAJznEpsJy0sLeLax7HG9HMmIw56J5ly31Lk5+lRUpdNWOgAMIgQJ4hbu1YPHj00FkEigoNPdfb/G2BS20u7PKQO8SzaXW7ra4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786870909; c=relaxed/simple;
	bh=Sj+LPkX87LuEdq1n2vLAbsQj7LhMcMzKl7u9lwxpqvE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Xh+xVin9bPMeGyj/ewP25n94Tv7DBpJQDqeEp/JlISLf4g60VRHqIv/FElrqO1Jp8sci7lQtougIrJqudPOUhBkr93Tg6CxbjwsweuVWlZ8tR+yVWyybHTiXxRGf1mRqpu71kX75jzGnDdQnW4oqyK6ke3uQ0inrMvAPh2Y5wd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=jM0Lzegw; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="jM0Lzegw"
ARC-Seal: i=1; a=rsa-sha256; t=1786870889; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XLfLL1N+AnqzFwXg586xF8QAQR/Mn+TYzYl/q93grOfvO/GI6BT9ZNIw/JWKrz3qvs8fk5kZZlm0lZTVrhatTAm843g+BWIU3O26IKoGBg+EsZFNXh8iOPdbfxFVDNiL9Yv7+rtJWpaI4rq42rsOXtkqeSyaSMK2pKzieFIbDTE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786870889; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uC0rrKBJiyK6GKrZ7oOkFU15ENgVC1tzNfFlEDiLMFo=; 
	b=VT5G0Kxy5ieuaptmWnpawbmpfuqkIPj66/JDgmVGL9F1E2XFNiQ9Ahni+YdBLdTVzmp1zyfBNX0F9xVjUS+Z5olYHk9DuaUTYmOQnN9sjc3aZUjz8itTXCvrwpY/FrGGMd7PMmPhLDwFMQ06qWTVrZm5uj6AwL/gqs50aCSMsVQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786870889;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Reply-To;
	bh=uC0rrKBJiyK6GKrZ7oOkFU15ENgVC1tzNfFlEDiLMFo=;
	b=jM0Lzegw6T4kcPJphd+ovvczrq7jLss4jh8upiRgtX6Dd8O8+kmInqknR1xOPjD4
	g8C2Dw4qXMMmzqr0NL0+HFBwpuXoknuIpjo8mlt6gpsWHOlAgEJrAD2JbnI/H7bH7mx
	AAewMjbMHQi1iJhyh9EMYZCgIm8ydAT8UpXxzF1I=
Received: by mx.zohomail.com with SMTPS id 1786870887237223.54892824363822;
	Sun, 16 Aug 2026 02:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Aug 2026 17:01:16 +0800
Message-Id: <DKQ8V08O8TKD.QHLCPR9W40HE@pigmoral.tech>
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Guo Ren" <guoren@kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Cc: <dlan@kernel.org>, <devicetree@vger.kernel.org>,
 <spacemit@lists.linux.dev>, <stable@vger.kernel.org>, "Guodong Xu"
 <docular.xu@gmail.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] riscv: dts: spacemit: k3: fix IMSIC guest parameters
X-Mailer: aerc 0.21.0
References: <20260816074125.2105828-1-guoren@kernel.org>
In-Reply-To: <20260816074125.2105828-1-guoren@kernel.org>
X-ZohoMailClient: External

Hi Guo,

On Sun Aug 16, 2026 at 3:41 PM CST, Guo Ren wrote:
> From: "GUO Ren (XuanTie)" <guoren@kernel.org>
>
> The initial K3 device tree used generic/placeholder values for the
> IMSIC guest configuration:
>
>   riscv,guest-index-bits =3D <6>;
>   riscv,num-guest-ids    =3D <511>;
>
> According to the SpacemiT K3 User Manual [1] these values are
> incorrect for the X100 cores:
>
>  - Hypervisor Extension: RVH 1.0, GEILEN =3D 8
>  - Advanced Interrupt Architecture (AIA):
>     - M-mode MSI: 512
>     - S-mode MSI: 512
>     - VS-mode MSI: 64
>
> Therefore:
>
> - S-mode IMSIC (simsic) only needs guest-index-bits =3D 3 (to cover
>   GEILEN =3D 8) and num-guest-ids =3D 63.
> - M-mode IMSIC (mimsic) does not implement guest interrupt files at
>   all, so the guest-related properties must be omitted.
>
> Although the KVM AIA driver will re-detect the actual number of guest
> interrupt files via hgeie and correct guest-index-bits at runtime, the
> device tree should still describe the correct hardware parameters.
>
> Update the device tree to match the silicon.
>
> [1] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=
=3Dhardware/key_stone/k3/k3_docs/k3_usermanual/08_cpu.md
>
> Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 So=
C")
> Cc: stable@vger.kernel.org
> Cc: Guodong Xu <docular.xu@gmail.com>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/s=
pacemit/k3.dtsi
> index 19fc9b49668e..4120eb0c4083 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -1127,9 +1127,9 @@ simsic: interrupt-controller@e0400000 {
>  					      <&cpu4_intc 9>, <&cpu5_intc 9>,
>  					      <&cpu6_intc 9>, <&cpu7_intc 9>;
>  			msi-controller;
> -			riscv,guest-index-bits =3D <6>;
> +			riscv,guest-index-bits =3D <3>;

According to the IMSIC DT binding, riscv,guest-index-bits describes
the number of guest-index bits in the MSI target address, not the
number of guest interrupt files actually implemented by a hart.

On K3, the per-hart IMSIC stride is 0x40000 bytes (0x200000 / 8).
Therefore, riscv,guest-index-bits should remain 6, which satisfies the
per-hart stride formula specified by the AIA specification:

  2^(guest-index-bits + 12) =3D 2^(6 + 12) =3D 0x40000 bytes

KVM already handles the difference between the address space and the
actual number of guest interrupt files. It reads HGEIE to find the
actual number of guest interrupt files and uses the smaller value:

  /*
   * Number of usable per-HART HGEI lines should be minimum of
   * per-HART IMSIC guest files and number of bits in HGEIE.
   */
  if (lc)
          hgctrl->nr_hgei =3D
                  min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);

I also tested this on K3. HGEIE returned 0xfe after writing all ones,
so the driver gets fls_long(0xfe) - 1 =3D 7 usable guest interrupt files.

>  			riscv,hart-index-bits =3D <4>;
> -			riscv,num-guest-ids =3D <511>;
> +			riscv,num-guest-ids =3D <63>;

This change looks good to me.

>  			riscv,num-ids =3D <511>;
>  		};
> =20
> @@ -1168,9 +1168,7 @@ mimsic: interrupt-controller@f1000000 {
>  					      <&cpu4_intc 11>, <&cpu5_intc 11>,
>  					      <&cpu6_intc 11>, <&cpu7_intc 11>;
>  			msi-controller;
> -			riscv,guest-index-bits =3D <6>;
>  			riscv,hart-index-bits =3D <4>;
> -			riscv,num-guest-ids =3D <511>;
>  			riscv,num-ids =3D <511>;
>  			status =3D "reserved";
>  		};

For the mimsic part, I already sent a related fix earlier:
https://lore.kernel.org/linux-riscv/20260729-k3-mimsic-fix-v1-1-368c0aec04b=
9@pigmoral.tech/

If you would like, you can pick that patch and combine the two changes
into a v2, as Yixun suggested.

--=20
Best regards,
Junhui Liu
