Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A721FCFFC
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948876; cv=none; b=q+XFSzJc7DV/yFwnJaPGvbxJLBnrmAc4eTInX0BPFZpa2cX115vo5BkjTj5iC+JLERLqZTFa3LuKSD1v5/YJdiif1BmBU58VKIMR1QqqsDqDaGwXKQhvmI8i4Qwbcm2o7n1ztfXYjeUVRpM/H2vbD9XrWZl4GfY0MYwggddYIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948876; c=relaxed/simple;
	bh=JROjnkSJB1U4ePqKZpqgur7TGgaHRduatsqZY6QLSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef43eVKzriCbXe0LRvO8qVyDjD+PmwcaW8TcVsPg4s9FigaUjhqR0sYsZp483Zn5CszE9Qr9w3vjAk/wkwMSQkWeymAXE8hI2gpyyC0MbDTg42T1Vthq5JBS3K6Cu0aThWMUJh9rqlArEhUyCPWJoc+6pY0hul7DvWSTl65qCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFM5gac8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFM5gac8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49249072f03so2607445e9.0
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781948873; x=1782553673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSYbUXTd9Ngne4Xxtlx29c5BFb1lGxLtQTLGucvyu0A=;
        b=TFM5gac8+4/nFSGFsuIRgp0qMJADu8yVC/P86bf3yF66Kgv7gx3DBj0aXcio16fSjm
         QHdInK3tjJo+LngGnd+dbLyPYw5eRltT1cn6MaiGLE2qpUDHlvp5yWomb8eratdaYXUG
         F6zXhKY0hr7AgXITIul2oprC9onDZeRHIutd7xS9QbHuCZ8+/1Cf1UIz7wNF/Y5SoNj8
         xbKZr6U9jK8WFOETJS5jQKh6KkBc02YMrgnR5NbrjR8c7IMxjcTdvnQfNq0BdO46qSr2
         NnYEEy2TRWEsVl0jJ4UupulKtLcdAWjmowSqMhQPsZlRHrW7/GSZdyHxThjeQdzkwHjk
         uAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781948873; x=1782553673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSYbUXTd9Ngne4Xxtlx29c5BFb1lGxLtQTLGucvyu0A=;
        b=QSqF9AQSB84TgiubNTQzwhBwwXYl6Er+XZNy2wOleEj/wECL/ReJLbZRjq2AqRJ48b
         kEbCjzZAicZoxGMAJV+GcUrq9Ywzu+0Wx/SnCCK8ODW7pkiOlJtZFUplgMXDoJrFtwoj
         NQd/Mre8Yup0yF5Jvp8tCIDVyzNPcswvrriEX9zg2KuADFVn+iWTAkomIOiCK+zZMWCP
         DSOuEMBsTV6F1GT3sv9mfImwKonyGCV+ezzuwZi2EnFu9FicRi8zY1b0qBdyV2dQsFYA
         8lMLqxlL0BYZWbtKDQqLB4OtqB//8BA8hZu0pCcPKdewZkH8Nl03wtE2BAIY0J/0kxU/
         heNA==
X-Forwarded-Encrypted: i=1; AFNElJ8VOZzfpaOhMvNbcB5J1sdCMPpkwfxuZKFXp76LiQf9z2BMhZIkm/+WQcRf9jK1Xd8jdd5A2+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVS0d4ww0jGv29fRk2HdeLiG+xSuLXwrGEiVe1/wzdYDZKlhU
	GMefY2zBjuYiJIvvjhkWQL6p9vR1eL9pu6kjBW5gUab80uIkunBRnInL4nYkO95P
X-Gm-Gg: AfdE7clXWBLbg0Su8gZlcDqJs61R1HyZohQswoCWLLgLBL04Nbkh/3I+CX38zqwnHmB
	Lg6JI6ML2+EbhxnZjIW43YLeCc5m3LYpnQmwl7EPoJSN1l4LxPEhPpzmLW4VVFKC+B7SDQCmZdV
	BuP3SXLP+RoKYLJavTG2DCvoyq/O/MeDdGsW0HVrMux57uFfiAnC6pyaD28HDUGa8vkoZtFpwmI
	S78FqzmBUwJBf0OOEAHB1ZsZR5tAHMuOCKsefX1ZCWAGLxdIiRkyeZ6Tkg9PkxQyGSyW5achdKX
	OnsbDA0XM5W3pwTCYEvAvWenA4TJT6B0HkZYzqcjYEHD3XG/+s0fT/nyzCEJGdXJxMhlVOYkea7
	GFCZ6DX8Papf9S7XC20vLsQwJMcawDIixJi8K39UUA4ENps6vGVpeZSM1DEPs5VFn8HCA762/VV
	oSs5zKZuKgfsHQRvi+YB/o71lJ1AmeXbZscjlEadc/Nzpidj9uH9a0aha9MmYw
X-Received: by 2002:a05:600c:8b42:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4923f5944eemr141374365e9.33.1781948872931;
        Sat, 20 Jun 2026 02:47:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240f054e3sm125314975e9.2.2026.06.20.02.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 02:47:52 -0700 (PDT)
Date: Sat, 20 Jun 2026 10:47:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Oleksandr Mazur
 <oleksandr.mazur@plvision.eu>, Andrii Savka <andrii.savka@plvision.eu>,
 Vadym Kochan <vadym.kochan@plvision.eu>, Volodymyr Mytnyk
 <volodymyr.mytnyk@plvision.eu>, linux-kernel@vger.kernel.org, Jianhao Xu
 <jianhao.xu@seu.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: marvell: prestera: use unaligned accessors for
 DSA tag
Message-ID: <20260620104750.5270a11c@pumpkin>
In-Reply-To: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn>
References: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 17:37:39 +0800
Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> Prestera parses and builds its 16-byte DSA tag from an skb byte buffer.
> The current code casts the tag pointer to __be32 * and then reads or
> writes the four tag words through that typed pointer.
> 
> The tag pointer is derived from skb data, but that only identifies the
> protocol tag location inside the packet buffer. It does not make the tag
> a naturally aligned __be32 array. Use the unaligned big-endian helpers
> for both parsing and building the tag.
> 
> This issue was detected by our static analysis tool and confirmed by
> manual audit. The same access pattern was validated with UBSAN alignment
> instrumentation by keeping the original cast from a u8 DSA tag buffer to
> __be32 * and reading dsa_words[i] from a deliberately misaligned tag
> buffer. UBSAN reported misaligned-access loads of type '__be32' in
> prestera_dsa_parse().
> 
> The driver has the same source-level issue: the RX path parses bytes at
> skb->data - ETH_TLEN, and the TX path writes the tag at skb->data +
> 2 * ETH_ALEN. Those offsets identify the DSA tag bytes, but they do not
> establish a __be32 object or a 4-byte alignment guarantee for typed loads
> and stores.

Stop sending these 'fixes' unless you can do proper analysis.
skb data is guaranteed to be aligned so that these reads (and ones of
the IP/TCP/UDP headers) are aligned.

	David


> 
> Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  .../ethernet/marvell/prestera/prestera_dsa.c  | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_dsa.c b/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
> index b7e89c0ca5c0..276f98cbd50e 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
> @@ -4,6 +4,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
> +#include <linux/unaligned.h>
>  #include <linux/string.h>
>  
>  #include "prestera_dsa.h"
> @@ -33,15 +34,14 @@
>  
>  int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
>  {
> -	__be32 *dsa_words = (__be32 *)dsa_buf;
>  	enum prestera_dsa_cmd cmd;
>  	u32 words[4];
>  	u32 field;
>  
> -	words[0] = ntohl(dsa_words[0]);
> -	words[1] = ntohl(dsa_words[1]);
> -	words[2] = ntohl(dsa_words[2]);
> -	words[3] = ntohl(dsa_words[3]);
> +	words[0] = get_unaligned_be32(dsa_buf);
> +	words[1] = get_unaligned_be32(dsa_buf + 4);
> +	words[2] = get_unaligned_be32(dsa_buf + 8);
> +	words[3] = get_unaligned_be32(dsa_buf + 12);
>  
>  	/* set the common parameters */
>  	cmd = (enum prestera_dsa_cmd)FIELD_GET(PRESTERA_DSA_W0_CMD, words[0]);
> @@ -82,7 +82,6 @@ int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
>  
>  int prestera_dsa_build(const struct prestera_dsa *dsa, u8 *dsa_buf)
>  {
> -	__be32 *dsa_words = (__be32 *)dsa_buf;
>  	u32 dev_num = dsa->hw_dev_num;
>  	u32 words[4] = { 0 };
>  
> @@ -98,10 +97,10 @@ int prestera_dsa_build(const struct prestera_dsa *dsa, u8 *dsa_buf)
>  	words[1] |= FIELD_PREP(PRESTERA_DSA_W1_EXT_BIT, 1);
>  	words[2] |= FIELD_PREP(PRESTERA_DSA_W2_EXT_BIT, 1);
>  
> -	dsa_words[0] = htonl(words[0]);
> -	dsa_words[1] = htonl(words[1]);
> -	dsa_words[2] = htonl(words[2]);
> -	dsa_words[3] = htonl(words[3]);
> +	put_unaligned_be32(words[0], dsa_buf);
> +	put_unaligned_be32(words[1], dsa_buf + 4);
> +	put_unaligned_be32(words[2], dsa_buf + 8);
> +	put_unaligned_be32(words[3], dsa_buf + 12);
>  
>  	return 0;
>  }

