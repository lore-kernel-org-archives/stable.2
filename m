Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795359209;
	b=XRR2EDp5MOcl+gKRAVOcQITR4eqoYlQ3pms/+pguJzQNseZPvSrq7/aM4CecfSYw5p90
	 q7TaYiylpBCgm2tjRuag4JY4iN9M+re/Sly4JaBEUR32Hr157EgsXepA4McSfbwVcwiE/
	 IJp29JDr8ypAr10Wrfh+8y0aPwxA429spOqtq8i3pYvaJ2mFAAqwAkMyB/sJ93salf/5m
	 /h3itZsFYqi0w68RVtrcdnXiZ/pRvXP5agpsYqPyjskxVCIKEEWBo6KnFVB+xMw3XaBs6
	 rjqOz/qxpHM+QKxUsi0nkzsDwjmABOFCvcJOBjdz2YWhEg8t3FfjPOz4ncD/rO3Cw7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EMg9eBblftcqvgfqSOCJqwI/WbN6M2N5ULmdtflQO10=;
	b=ilxmZkSdd1bwrUidlkb9r7vW7WW8e0/17peXJSwJwk7Ad5NJ7HDra9ClOirnyeQQZBJc
	 jkgjN3JA/mtG7Uhz3ZfeJl8nLh5wxEaItWZG90FH//ROCYVJISmPm4Ldnx2iH3DN5f7pE
	 D//uhxY1hO50O53SD5IpTOIl5x4aCwoMritVUsIQsphaMnGQ/7+1QmSfaxB7oCWC2pErO
	 TJ9EBp4xjYuJ7WXCkKcw9uXxXjsb4G0WRe/6BRHEsXaRpexFO2XCsNvbFdh8JqSCvcG0N
	 /l8j58yf6mNauWdqZK/yLHXWkdjrtjjcUZLdygu+VoSygy81k3z/hVmVfBVl6HgrZNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=CJGTpRWZ;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D519606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 14:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D519606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=CJGTpRWZ
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55ade1de0b4so31250971cf.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 06:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795359208; x=1795964008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EMg9eBblftcqvgfqSOCJqwI/WbN6M2N5ULmdtflQO10=;
        b=CJGTpRWZ7MB0kqT+KQmoAZZ05PqUN8xlrDUyUH+gA9dQc+IVgh7WYUaNUkwrQwZAZ2
         ChpqZeQ+CYR9Awi+y3E04E6Ni2OC5AYQWyEGoeOv+hRt8ClNtUkW/ZdW8jqnJcGZ8tLF
         An1XXfGomIK0ppeaYoOVRw5pr5mzk+24zHERDN4X59UjldMVQrMnHp194pbUuDo5QTlr
         wiC3XOeYPv/hLWZ8h/AigmfQztx0BK7EzHkpRQZcePV1Uqkj67KpHVauF4phFnc/WiQ9
         pKWRwTfkMPfoGr18gC5Khgrq7y+4LGaouaiuYr6v4QA2tA+9VgDBCnJBpMjqHoaRlHF/
         Hyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795359208; x=1795964008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMg9eBblftcqvgfqSOCJqwI/WbN6M2N5ULmdtflQO10=;
        b=sjzjRZOG2AxiolENVS87G5iJZUdMcy8eNCEBiV5EvJGicQw133CtLy9OhmW8Ek5mM7
         DjNhpZuu+rJE8+hZW90KbY2YMoiL4DfYPRYcOtJw0TkaS7rofzp5rODJXycCyUFasgv0
         JtAGetJlioOXDNLE4buMzKW0oju+vp4xVgItzvJ5nssfnBVjYOhd8YtN6pd5bc+GtzWO
         XBdzLhkEKIF6qmay0adzPCE9luLM/E1gdfTmwM9YtQkY4qKfrZDVl4+Bq7HSWULw0jaM
         oYP2Wu2lO/M1FnaGCXdbpLmCoETNOPTQ5ZRGlDUkn2//CE8snnAAlB6+3HQu6p4lWgXH
         wxXA==
X-Forwarded-Encrypted: i=1; AL+hErH2EXxbKNk0Vun0vh29ZWFhmhSIRlNZcJbDLf8+vSdJdmnoWWRatBIc59zyUnMQYznDSdY4WJI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/V6jJMvhnanXhobS97X/C9sZSw6K6tnXRm4rZtBLapOnGq4daN
	4V2Fm49aoTgycpB8nrLM53gFFwidwdlzyIin72/kVrzIGp0oLwgGUd+GYaFnHtR2hA==
X-Gm-Gg: AZFdTZdp7JB1nFf5zZ9dO7qxEvQlTahdmRQTwz5pAIgbfCw9qW70pXR2ZcuDSxhARm+
	N8A2QyxRHt/NQGRJoSb53I/82FL8YEqPn6u8JKewsOPbRD24lTSDfS1VUw1uvFA3MG3dsJBiZf1
	r/oZvqA1/JSVRBrDgyVHKj1+YaqwFfSiCwm+P5kkoTHNDajMrTeBl14MmgTnPu/n6+VqmJdXtuk
	cfHtypRmreBmHLoVjU2W7WSyE5UPPWcJ0YYQ0SEgzc9NnMFJobai/z3OY7Y2YVISnadeyH0OUTP
	i8fZgo9NJku6R6ehCEtk4T6CSOhwQ1E6psIyyKpvZj5uit7vxJUM32rWv/BX39sqOLQwCYIK2zL
	7ZNc++YYbr+FPi4AMcmTe1h6AlgzXnGY8t1/ARueDnbN+mcXr3a1vRI0S1NUg7x3kDgl74iRLa7
	U0sxJw8RCtTdM73+jeQTtymLkE9cdTN1XEgrIkZOWgaYHoLzZml+799wvc9maJfGijPJoezJJWA
	cX1CjY0rF/lbOngY6HwhcEMuTeytVv5CwlSzgXYDOF2eDo/FdWIHt9HZH7uP32g1rdowOW1Y5h5
	WAD1k/FVME084/gI6B5/HGanVHuJAw==
X-Received: by 2002:a05:622a:514a:b0:536:61d4:cc6d with SMTP id d75a77b69052e-55d76af2778mr156555621cf.53.1795359208144;
        Sun, 22 Nov 2026 06:53:28 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134bfe82dsm78713746d6.0.2026.11.22.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:53:27 -0800 (PST)
Date: Sun, 22 Nov 2026 09:53:25 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Arbab Haider <arbabhaider649@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shichao Lai <shichaorai@gmail.com>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: alauda: track
 media_initialized per port
Message-ID: <ac19e630-f96a-4144-88dc-e3f22091c7bb@rowland.harvard.edu>
References: <5d2e1310-88db-427e-ace0-c2a0590560b1@rowland.harvard.edu>
 <20261122080550.2181-2-arbabhaider649@gmail.com>
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
In-Reply-To: <20261122080550.2181-2-arbabhaider649@gmail.com>

On Sun, Nov 22, 2026 at 01:05:51PM +0500, Arbab Haider wrote:
> On Sat, Nov 21, 2026 at 03:54:57PM -0500, Alan Stern wrote:
> > Has this patch been tested?
> 
> Yes, tested in QEMU (x86_64, v7.4-rc3 with KASAN, UBSAN, dummy_hcd,
> raw_gadget, and usb-storage alauda enabled). I do not have physical
> Alauda hardware, so testing was done via dummy_hcd + raw_gadget:
> 
> - Before the patch: running the syzbot C reproducer reproduced the
>   UBSAN division-overflow / divide error in alauda_read_data()
>   (drivers/usb/storage/alauda.c:986) on LUN 1.
> 
> - After the patch: the syzbot reproducer passes with no UBSAN, KASAN,
>   or divide errors. I also verified additional raw_gadget scenarios:
>   * READ_CAPACITY and READ_10 on both LUN 0 and LUN 1
>   * Media removal (status 0x80) followed by re-insertion without the
>     0x08 media-change bit and READ_10
>   * Media change with a failing alauda_init_media() (unrecognized media
>     signature) followed by READ_10 and WRITE_10
>   * Recovery back to a valid media signature with TEST_UNIT_READY,
>     READ_CAPACITY, and READ_10

I asked because when syzbot tests a patch successfully, it provides a 
Tested-by: tag and asks to have the tag included in the final patch 
submission -- but you didn't do this.  Did you run the reproducer 
locally, without using the bot?

Alan Stern
