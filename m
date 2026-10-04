Received: from aib29aea146.syd1.oracleemaildelivery.com (aib29aea146.syd1.oracleemaildelivery.com [192.29.151.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C83B42FC
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.151.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791077277; cv=none; b=Or5pOLV2r6PtW2qozu1CO3G1RPCC31eC9tvnGeyBehdRmKmNSC6Ivnw+uQWke9Ko4QavTbJTl5c8Vmu5he02JK9vp+AP1a8eX5JIGvlgSK+4ZtMAV4aI5jmQE182nwwkL+Wxg6YOLiGgXAj5c8AA+BtXvMcbC6q1BqKu0xrBEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791077277; c=relaxed/simple;
	bh=YHwjaGEXhooScUMhN4sjKblUiQTTIR+wIjD3ycbLnbQ=;
	h=Message-id:Date:MIME-version:Subject:To:Cc:References:From:
	 In-reply-to:Content-type; b=YT7xDl4XOhksep5xWo8qx2FYBKPXmcsAd9cDVpFUjD49lNcM9eS5xPGyiRvK9b8uAXSCxPN4gUlH149f0ByVnebdWP9k3SMd8PxZP8HPRTv525gy4gYNWHzlnnk/VdKaAiONZyWpKTl74XCm3GNIdNjAKaUAu8JXg3rjq7JYf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stevetech.au; spf=pass smtp.mailfrom=syd1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=stevetech.au header.i=@stevetech.au header.b=cbW3AksY; dkim=pass (2048-bit key) header.d=syd1.rp.oracleemaildelivery.com header.i=@syd1.rp.oracleemaildelivery.com header.b=s9555o/f; arc=none smtp.client-ip=192.29.151.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stevetech.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syd1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stevetech.au header.i=@stevetech.au header.b="cbW3AksY";
	dkim=pass (2048-bit key) header.d=syd1.rp.oracleemaildelivery.com header.i=@syd1.rp.oracleemaildelivery.com header.b="s9555o/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-2026;
 d=stevetech.au;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=kpjG6rYXPTe/tizbo7cfjo5Jk+SyMjAmc1fPSNDuai4=;
 b=cbW3AksYlCiVYo4f78vG39yHidUlbfCuSfoGl3exllClqoNX9m4xELXIfTjHgJ74I+Y0Ac4vwX+Z
   5CG/WEWR/AIVY0NfgnrFF+gYWZkA9p6DGa2KxqCDspnqSOnS2PM1dr3WbnQpYVM/hGyBi3LaBgLm
   3uZ1eLHzhNaaRmBxFFf8UIKEElE5ZTJJZ1jYxxQzw8+oE5Vgv4iGYHOhNez6mzs3hWYpn0+1acv6
   M5zCCe6PVrE7v9jhFSTwGPuEq5RPCJyhoRXoE7FNqk/PUnzmO7/F8uUY4+610DqNBppOdXuqRyRn
   hdbi3+671MSNRehit2scMNiIhhBCUgeHzJnv4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-syd-20200122;
 d=syd1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=kpjG6rYXPTe/tizbo7cfjo5Jk+SyMjAmc1fPSNDuai4=;
 b=s9555o/f7z3/C54ugK5sE9vmtOPmAqRcgz5XdGwhK7gwt0sIn+KSU5nv1L6wCfTMHWsR06u3Kawz
   hKCxfkdEs/oWoBBpNxZA56cGQK1kfW3WJF3hiT9UCVq4354waSBIijNJ6mhLdXzl/ID/ekczKkiD
   ugDsjr0Ilv3Xrk7FzlyNpXgJIWS8xg4BCAfUzOkZvs3nS5qKew/WDBPtHoY/tPoQt/Mee6txY6P2
   qDtFXoGhBGYUyWHcA5ppe3+cnY0Hh4qacAbLZqHaRnRzVH3i3CRALPTA/3yTPACVeLYRFyTV02yi
   GSCRHA7iYSh+ODruUe+zb+/MkdydViDWZeyTSg==
Received: by omta-ad1-fd1-1402-ap-sydney-1.omtaad1.vcndpsyd.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260817 64bit (built Aug 17
 2026))
 with ESMTPS id <0TMD1XHOP02GE4B0@omta-ad1-fd1-1402-ap-sydney-1.omtaad1.vcndpsyd.oraclevcn.com> for
 stable@vger.kernel.org; Sun, 04 Oct 2026 01:27:52 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Message-id: <736f095c-d7d3-4023-a2c0-0b5fbb1baa78@stevetech.au>
Date: Sun, 4 Oct 2026 11:27:49 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: xhci-pci: Add AMD 600 series to xhci-pci-prom21
To: Mirko Jechow <mirko.jechow@gmx.de>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Jihong Min <hurryman2212@gmail.com>
References: <20261004002731.49927-1-mirko.jechow@gmx.de>
From: Stephen Horvath <linux@stevetech.au>
Content-language: en-AU, en-US, en-GB
In-reply-to: <20261004002731.49927-1-mirko.jechow@gmx.de>
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 7bit
Reporting-Meta:
 AAHV7gL8JXoT6sfqXyJYFrulzXJdLpnzbDVduAssYr0JF2y5vo/IUbz12dA/L56G
 IrlTQ/k3MADBWKY+uIyDVcindxxYfs1QOPRycxiOD/XA6Bhq74aL3kMKSZCaTgbE
 v6ydW/eI+untYIRb+7ttlnDSNhsaM7HkNCz79VHp7lEuN1DsLTF3+FkryRrioDrU
 utstbLUwX9Yz/dK4yKCiJ2I95SzkSFF6Rky8ya8Ca0CZADzf/eIptKcw106D3kNT
 PLATWSd1P4tMGaxZxc09HenWgSS43sVo0nexg1eWoZ474eRMiB8voHD9F6i34gzd
 c1+IzEPQeetZjoIKfVddyf4Ye64o8vY7LP+qFLqz7r2XGmxbp1w0tinJBdbKF7HD
 n94JtoS4rrnlZ6/XkdvByjgicQ0AEEmAz751pmsiMJIBN10xiya6SN5uIDFbu9g=

Hi Mirko.

On 4/10/26 10:27, Mirko Jechow wrote:
> From: Stephen Horvath <linux@stevetech.au>
> 
> It seems the xhci-pci-prom21 module only has IDs for the 800 series
> chipsets. However, the 600 series chipsets also have Promontory 21
> chips, so we should add their IDs to the list as well.
> 
> I have tested this on my X670 board featuring DID `0x43f7`.
> 
> `1022:43f7` also appears on the PCI ID database
> (https://pci-ids.ucw.cz/read/PC/1022/43f7).
> Device IDs `0x43f9` (B665) & `0x43fa` (A620) were suggested by Shyam.
> 
> Also list the new IDs in Documentation/hwmon/prom21-xhci.rst.
> 
> Cc: stable@vger.kernel.org # 7.2.x
> Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Cc: Jihong Min <hurryman2212@gmail.com>
> Signed-off-by: Stephen Horvath <linux@stevetech.au>
> Tested-by: Mirko Jechow <mirko.jechow@gmx.de>
> [mirko.jechow@gmx.de: add new IDs to prom21-xhci.rst]
> Signed-off-by: Mirko Jechow <mirko.jechow@gmx.de>
> ---
> Changes in v3:
> - List the new IDs on the PCI IDs line of Documentation/hwmon/prom21-xhci.rst
>   (requested by Jihong Min)
> - Picked up from Stephen; v2 had no follow-up since 2026-08-23

Thanks for picking this up! Sorry I've been busy and forgot about this.

> - Link to v2: https://patch.msgid.link/20260820-xhci-pci-prom21-v2-1-638e5958fbbf@stevetech.au
> ---
>  Documentation/hwmon/prom21-xhci.rst | 2 +-
>  drivers/usb/host/xhci-pci-prom21.c  | 3 +++
>  drivers/usb/host/xhci-pci.c         | 3 +++
>  drivers/usb/host/xhci-pci.h         | 3 +++
>  4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/prom21-xhci.rst b/Documentation/hwmon/prom21-xhci.rst
> index 7984fb187bd8a..6c0b6e7368921 100644
> --- a/Documentation/hwmon/prom21-xhci.rst
> +++ b/Documentation/hwmon/prom21-xhci.rst
> @@ -9,7 +9,7 @@ Supported chips:
>  
>      Prefix: 'prom21_xhci'
>  
> -    PCI IDs: 1022:43fc, 1022:43fd
> +    PCI IDs: 1022:43f7, 1022:43f9, 1022:43fa, 1022:43fc, 1022:43fd
>  
>  Author:
>  

Looks good to me!

Thanks,
Steve
