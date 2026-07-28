Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4E2D7D3A
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203967; cv=none; b=KXsLHDN/prNPtO/hpbRT8jLpJ8HfpSqDrfI+Vb2SYiBdAvzd7aVu7IDZksIKLnZOmcYv4TLVSc/JERYqw4XAS9LgHsISjv0IOGU7BvfY+GVdlz+lXiH0lHVjtZbbT3GD0GZWK9lBs865qhconvb8+9Lglw184ERo4+/M3NmR8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203967; c=relaxed/simple;
	bh=CawxVQkJNWG9UC33bH4B6QtHE3fIWQSW2rF6KQwMMb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r//XOdxKnGisClGq27ABBpEvvWSWY22BXigaUy5eBpzDkfqkv28XilJFSiTSfvX96cUJMvH8H7Pnii6Nsi9htNdN+s7Z1jEJH4X2rcE2E3cvbKV78WpLQW0OXF2QvhoVPXoc7qityChjkmxpa8dSEq4XVJR+zka3lVIkB10oZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=nj62HUlQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="nj62HUlQ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f256eaedf8so34783546d6.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1785203963; x=1785808763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xsIjQv5H0VfbYXJqKAEeCyOCnADFtFqc7MMDYt9Qh0Q=;
        b=nj62HUlQgh8z7YtRj9LjYQ2IGqVAX+3wuTr5HVhWuDT3J8RQ03uR18aHDmiSHZFrdH
         t6uyVfkYMh/Czg5fx0WGJertLzsbNPLaT2/bZsQKeSVyT2MFulWqnLEl/VGl44X3dqlA
         wSTgXoe+1hd+cvsdyUcQLHMarIJnX35XMi8MRn0UKyvehUJfkM+EnXifyqNTA7pAkbIL
         T1rL4whG/PkOKQCQQ0UssCifs56RwaSc0p8Vhg45bvFc9RZopFQ+lYHIMlOzjFcTjKav
         srWVa2yBqzjSJlpJ7JkI0BgdsqpxdDsQNJti23XtEr6OveOn0DvbMyAWM2txYlpfrmqU
         y1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785203963; x=1785808763;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsIjQv5H0VfbYXJqKAEeCyOCnADFtFqc7MMDYt9Qh0Q=;
        b=Sd0WnuHGtbLvRTtsGyOIURJfI82f5x94uUXFptBVUKUdIPorcsPZwl7JZvAYb4s7Nn
         OLN4vbaM0xUz/mBMSNAg72bSVCY7iidzM2hj/svE7y7KAoUTW4ynqNU7A9DrwTDG1FSV
         +IGu77OAImLQd/d1qO34u/x9Hh/hRRWJQ3/YiSpSZ11t/IVin9o0dtA2V/+nZjrwSsQ/
         gx8tMl/jOx8NQWjbsPe9wNrCaLXfQBHEEbhupGSZhNs3FRC/FWbdVQzzEm7bKDQ2Gcnz
         By1bXH64umUZZe1SCB8otZuWXtocFP/6r1KUIAlDvEi+fG6cbbXpACRETviR+A2uL+D/
         YVCw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5ICvaNqeG0+Pm04DiKwWVFlyKrx0FCcVol88fJEvjhwaaEEPPxU4T6IazcYZ0v+jbgIkqTsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCf0ikecHeaSl4Y7VmlCyJa7R6qO8/daljra0HwBz5/KmvuK36
	OLDS9GASMcQPF/oFwXiTs8i8Dlm1ZyxRKOUjxhBgdIrL7eDTusEwD9kEPTQFjphb9A==
X-Gm-Gg: AR+sD11M2W9MzwLA2HqtvoC7VVcerevaUSRZzt/Wj51ypedioO9zjQhP3ewhQfLRo7S
	JbkXDwoXwLXtcxqNztogeeleVUEF7lQlTJq04VCZeu71kxt3H2JV/3wjH+TQpVgwGfAIZwI79Tq
	XbSEmP3b8mkLLtAvhobh3reEocdW+TrnFTE6KGH/2U0IMAeB8+cnP54k0sar8PIep4GLHRFvP8p
	sl2E/hUwvSKVFD6ig6qqOV6kVC4QnlFC7U40ON+FBc7JaXxWpH+ud2UNGNQuqAaDYqfH1XboRdU
	NH7oGqfLu4HM1pH2mqXk/CIp5DutyffD7CjsjglcwIc9G+f4IVMgMn4UdUrYrPIxmlieEDl9P6A
	4cWlFCc3R/be3uNY3mU1REg7p3mCa6NvHYrMbCNliBIHVzaDsJS2aOiB4BZ6BJlF7lRBIGQzP+B
	+SziE=
X-Received: by 2002:ac8:7fcd:0:b0:51a:8835:58cb with SMTP id d75a77b69052e-529d71d8c6emr3037201cf.54.1785203962951;
        Mon, 27 Jul 2026 18:59:22 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::883a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e85215d7sm78094896d6.9.2026.07.27.18.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 18:59:22 -0700 (PDT)
Date: Mon, 27 Jul 2026 21:59:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	corbet@lwn.net, skhan@linuxfoundation.org, stable@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] usb: core: Add quirk for 255-bytes initial config
 read
Message-ID: <ba2af6f4-0134-4feb-addc-24694fabeb10@rowland.harvard.edu>
References: <20260727195434.14626-1-nikhilsolanke5@gmail.com>
 <20260727195434.14626-2-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727195434.14626-2-nikhilsolanke5@gmail.com>

On Tue, Jul 28, 2026 at 01:24:33AM +0530, Nikhil Solanke wrote:
> Certain third-party USB game controllers exposing (or spoofing) an Xbox
> 360-compatible interface (VID:PID 045e:028e) fail to enumerate under Linux.
> The device disconnects from the bus without responding to the initial
> GET_DESCRIPTOR(CONFIGURATION) request, and the kernel logs 'unable to read
> config index 0 descriptor/start: -71'.
> 
> The device then falls back to a secondary Android HID mode (with a
> different VID:PID), losing XInput functionality including rumble support.
> The failure reproduces across multiple machines, host controller types, and
> kernel versions including current mainline and LTS. The device enumerates
> correctly and remains in XInput mode under Windows. Notably, the device
> enumerates correctly in Android mode when the same 9-byte request
> is issued for that mode's configuration descriptor, confirming the firmware
> bug is specific to the XInput mode.
> 
> usbmon traces from Linux and Wireshark/USBPcap traces from Windows are
> identical up to the point of failure, with no visible protocol-level
> difference explaining the divergence. The root cause was identified when
> Michal Pecio discovered via a QEMU bus-level capture that Windows does not
> use wLength=9 for the initial config descriptor request; it uses
> wLength=255. Alan Stern subsequently confirmed this with a bus
> analyzer on a different USB 2.0 device, and Michal verified the behavior
> goes back to Windows 95 OSR2.1.
> 
> So, add a new quirk flag USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE which causes
> usb_get_configuration() to issue a 255 byte sized configuration request
> instead of USB_DT_CONFIG_SIZE (9) for the initial
> GET_DESCRIPTOR(CONFIGURATION) request, mimicking long-standing Windows
> behavior.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Suggested-by: Michal Pecio <michal.pecio@gmail.com>
> Closes: https://lore.kernel.org/linux-usb/CAFgddh+JWdT4LLwMc5qjM8q_pBu-fRo2qADR5ovAKoGHWMQrRw@mail.gmail.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
> ---

Your patches basically looks fine to me.  Just a couple of things to 
note...

Personally, I prefer to see comments that don't extend beyond the 
80-column limit.  But there's no hard rule about this, it's just my own 
preference -- you don't have to change anything if you don't want to.

Also, it's odd that you add the quirk flag to the kernel without adding 
a new quirk entry for the Xbox 360-compatible devices.  That doesn't 
have to be done in this patch, though; it can be done in a follow-up.
(But note that without a followup this patch doesn't actually fix 
anything, since a true fix would require user intervention.)

Finally, a really minor nit: The two patches in this series are 
completely independent; either one can be applied without the other.  
That means they don't really belong in a series, that is, they should be 
submitted as two separate patches.  Obviously that doesn't matter at all 
in practice; it's just a matter of principle.

Anyway, for both patches 1 and 2:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

If you want to rewrite and resubmit them along the lines mentioned 
above, you can add my Acked-by to the new submissions.

Alan Stern
