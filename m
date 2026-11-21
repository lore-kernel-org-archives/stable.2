Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795236758;
	b=c5P3NbMM7Xsca6P3PBvMdPRXVppwnKg+zSPwQ1d8J9yWoiC6Uu/6D0SZHJfo7R+9Dbln
	 QYSTJNDIEdDlEO27jmuTJXB7k68s5E1+l9Z78Sc8UCSk8P2sreJSSSBjfqgZg4jat5IrA
	 lIv3EmgXz+iZb2ruyQCEtM+aRxv0PTPzDTSLrmMPLEdu4vYjxlMnCrDc84ycyek4zp4or
	 UcfC1Bo3NiyiO1nseLRTm3NJmKYFVPkZmaua4Q21cTfZcLF+lJgX+CxlR3CfJu/Ihb9Vr
	 vKHaqKyMfzb0xqX62Wxl/ACy9dpcElGQoq5Z4ZMFbksJb3wEIJ39ctX1Go58H7fQZqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795236758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BElOMUrNe0Z5QYnSCoS/+yWntHOMYQVZ5Afv4DN/AaI=;
	b=z1e5iRmSS9mCm5nyjVpcDZKNQROe3ekFJLEQcPHCVYbUDNNtzMwMN3EDx82ya69yswnW
	 q6IYZpHfriKVOgIYcNoZVHoap6cDD/n5gwq9ljVCpBhQXojWIkXi8YGwoNy2+7FEMMNHy
	 miso6TlrEAFsRrYqwGbS2UDGONhgUMqrLLUHCt/BBqm5w3xQHt7aM174L+wvvJEwTXgg6
	 PvTvUeyu2V1Y4RxXB/jRxPlzn1gCYa94QNQvqDhoDQPoccHmUrgd4fuf94zCnzgcY8oDT
	 WlhvmbhUoi81tEh6sd4jEHCy9wxkfLU8WF3A1OdbnoO2QiiL8W5a5m8OJQbhJghE5nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osE5io32;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C4606A69B
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 230C4606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osE5io32
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f04244c3d0so13272455ad.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795236752; x=1795841552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BElOMUrNe0Z5QYnSCoS/+yWntHOMYQVZ5Afv4DN/AaI=;
        b=osE5io32Nn+joBzaP+hIKzyy3vwwae6jNiXdeduuKXzDOQmy/aTxCjtXJ0dVmb2Pyj
         YSmpNyTjqlKfPr1V2DiAX0YDroo6VjWzd101rYQDnedG1vup2EbAhn+3KAXjU+LUnmgM
         gfyPDuxzNdiQYetCoTZr5sVryKmSlTADx81HolfEypNEib998tniFukAuBKuu3pWNXPg
         YbKSJhvUXWnFqCMMwbPe7iGq7BotyP/lShDBV9N345VfDpA8DcLNQVa+izHNTcg39TSq
         yMdYoye2Moc/rnamKzFPQCAJzpUxFc3pqsnjhylsb0Zsk2AnbLs18Y3uK5aVRCKStM/8
         OZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795236752; x=1795841552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BElOMUrNe0Z5QYnSCoS/+yWntHOMYQVZ5Afv4DN/AaI=;
        b=tTCVFsKNk0M7pjwHy5xO0LbOyJANoTnfwKNZcqMIxUPFW5Vye+5Y79aEG2S1U5uLZG
         Nh+xad13LsGWFpusxRTU61juM7+jy/tQINt9VQOufRh7cFonuMxPIBkoa5/4D2qkSb1u
         9WQ7Sb7lJu1oHgNov45URpHGv0S/EfPVYZA4BZOMwJgJQKkXa/1ErnGkMbcAAIdkYRLS
         ljF/YYuMVEShmC+lrf6Jg3Icau4APchid2fGsd6G0DNasRZ/VaUbIzRzvNayPslfXf/u
         RU02JWrJH76BrEoxQ1vkgDbnQAFZgqtUreN4RwJ6JVnDcLPQYfRDwR+nQDTR39QISive
         DJTA==
X-Forwarded-Encrypted: i=1; AL+hErHe8s+Ob7529RfgUm+nzc83yPuve9u+jZbjsYpysLo+ixLcTgJuWgzlWNYPsYhTbzrrBjDBkws=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XotrH91LvspxCFyJfUxcumeTAU7R5PaOCSCdMQ3/oZU9Gim/C
	nIGyLDPRAEUcLw3m84VsKVXshT8VvezWBS7D3m0q1+NGskx+3yqmu+QC
X-Gm-Gg: AZFdTZfymisojPVKGO5SV7omRgtJLdWYes9a1ueU73s0eLykAvtPirHjP7I6rFH0Svw
	3croDsqqbJrt5rnKFs8qqU2FYorihqWJG3WDOdot84aK/vh5gpjdBMEb5pTK0egzKBtFlJvQ9ks
	5KqRUGbxk7LfOJHkJZBtMYZhW5SGSJEbyfk3uerf16bBOEzU62gmgJr18pREKbSZKv4GWsV0C2d
	hE75Bh/0TSeLuARL8Hm8oXk9OZzLGsIHChrJY30pr0xPhqIWcYxRlX4sjA7/fVId+TTkkTYEa39
	sY+M/hI/WeLzE054Pkg9YWemqiVmK0JVyfoPLnGEobpkMoK4suudDvvEnTzJGiMlCXcq6Gu1yfQ
	/IbcxLJHlCD9zcN+mC85lGTKhNyIzmrs/Wwwjys3cic+Ru17HLYmeT6xp7Y0r2GgzW64GgnNOVA
	0aCmAUH3kfVhq+e2qDXOFlzRQMKUesHtFBxRu21GDtpicCmoVILy6zrvtk4oSFchtRU6XTY9BT5
	s5bXcso1y2XQhyZBy532cEVq+RQ2ZW/cxXvETEmZIzNFdCjtXrGicwv/T0lFoDm2Ur8Xl83x7dL
	ydPSAmA+3mjhrYAoIFbSdIwcOUbBB0WEnyA5ldupHSnV2S04U3A=
X-Received: by 2002:a17:903:240e:b0:2ef:f656:2dc2 with SMTP id d9443c01a7336-2f03f14102emr56430895ad.31.1795236752418;
        Fri, 20 Nov 2026 20:52:32 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ab7sm21421395ad.15.2026.11.20.20.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 20:52:31 -0800 (PST)
Date: Sat, 21 Nov 2026 12:52:24 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 5/8] gpiolib: cdev: don't leak the IRQ name when the
 chip is removed
Message-ID: <20261121045224.GB17013@rigel>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
 <20261120-gpiolib-chip-removal-v7-5-aambrozewicz@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-gpiolib-chip-removal-v7-5-aambrozewicz@nvidia.com>

On Fri, Nov 20, 2026 at 10:13:57AM +0200, Adrian Ambrozewicz wrote:
> The character device requests line IRQs with a copy of the consumer
> label as the name, and frees the name that free_irq() returns. When
> gpiochip_remove() frees the IRQ first, it drops that name and the copy
> leaks:
> 
>   unreferenced object (size 8):
>     comm "gpio-hold"
>     backtrace (crc dc8eac94):
>       kstrdup
>       kstrdup_and_replace
>       edge_detector_setup
>       linereq_create
>       gpio_ioctl
> 
> Keep the name with the line or v1 line event, and free it there,
> whoever freed the IRQ.
> 
> Reproduced with gpio-sim: remove the chip under an open request with
> edge detection and a consumer label. kmemleak reports up to 23 such
> objects after 30 cycles; with this change, none after 100.
> 
> Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
> Cc: stable@vger.kernel.org
> Reviewed-by: Kent Gibson <warthog618@gmail.com>
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f2da4f2646bc..fdcd315e776b 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -400,6 +400,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>   * @desc: the GPIO descriptor for this line.
>   * @req: the corresponding line request
>   * @irq: the interrupt triggered in response to events on this GPIO
> + * @irq_label: the name @irq was requested with
>   * @edflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
>   * GPIO_V2_LINE_FLAG_EDGE_FALLING, indicating the edge detection applied
>   * @timestamp_ns: cache for the timestamp storing it between hardirq and
> @@ -423,6 +424,7 @@ struct line {
>  	 */
>  	struct linereq *req;
>  	unsigned int irq;
> +	char *irq_label;
>  	/*
>  	 * The flags for the active edge detector configuration.
>  	 *
> @@ -602,16 +604,18 @@ static inline void free_irq_label(const char *label)
>  /*
>   * gpiochip_remove() frees the interrupts still requested on the lines of the
>   * chip being removed, so once the chip is going away the IRQ may no longer be
> - * ours to free.
> + * ours to free. The label is kept by the caller as free_irq() is then not the
> + * one returning it.
>   */
> -static void free_line_irq(unsigned int irq, void *dev_id)
> +static void free_line_irq(unsigned int irq, void *dev_id, char **label)
>  {
> -	const char *name = NULL;
> +	const char *name = *label;
>  
>  	if (irq && irq_has_action(irq))
> -		name = free_irq(irq, dev_id);
> +		free_irq(irq, dev_id);
>  
>  	free_irq_label(name);
> +	*label = NULL;
>  }
>  

The function you are modifying was added in patch 3, so note that this patch is
dependent on patch 3 in the description[1].

>  #ifdef CONFIG_HTE
> @@ -939,6 +943,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
>  				return ret;
>  			}
>  			line->irq = irq;
> +			line->irq_label = label;
>  		} else {
>  			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
>  			if (ret)
> @@ -981,7 +986,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
>  
>  static void edge_detector_stop(struct line *line)
>  {
> -	free_line_irq(line->irq, line);
> +	free_line_irq(line->irq, line, &line->irq_label);
>  	line->irq = 0;
>  
Similarly - but you only need to note the dependency once.

Cheers,
Kent.
[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes 
