Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E54367B7E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505045; cv=pass; b=gzOZwhk9NvpNFk6tN/J7TqZ74n4gclC6ftFTsXd3S7DCKfUaoVeCbmHKe77B24yiUq75XVpHMlrhxYgiR/3rFy62pn0VwtIJ5stDEQ2VPEv2PWikqpfQZkTx4hOX7Y3ZQnmwJvNvYQU8LW7raS+Cv35eQN09O3wBUGE4TfYN9yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505045; c=relaxed/simple;
	bh=zBt/qZgsLXTMNMb03BartQTDgFJ4whNRfaR5h2RGGdA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sKcXeJ5OoNHBzo3jgjsz94ZFfHK7G/YIWPsL21fEUoFcC5CLmj6hL4FCYR68jGYrYjPXFB6B4KvjdOmvJtUmov8220YXtheA+JHhTbP5bB4z+9oGXmnk92AWx63k+IxTzF1obodFHw4YvPS4FCQrNOOQo3iLWrvWf9jviHCKrj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV/2LRTS; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV/2LRTS"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66b2c08803cso660302d50.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786505043; cv=none;
        d=google.com; s=arc-20260327;
        b=QkdjwuJx/0gApkSo6jroYbX/8IeBugT8jcYFbssvRYYM+e+dB2ZQgX6Bjmha9oB+EN
         +RFW8C3Og2T6xku+FBCK9gxc09F3ZFU6jMwd+yMOhfrfHBtu1CEToOUPuJVJr21jxAr/
         /8s/mjLwUjCM08e1aNE4GMVmzFtdtguCJIU6H8RKtOay5fHj3BMx/KbcQR0WBCke42iH
         KQLVjGEuIa0L3ij6Cic/TVP9ud1A/GDg+zatkA17pExD8/C0Ql3zCGHkHbBmTeMJeoCP
         V5iXZpjVzCvDNj0vkghRg5zeDgxCvIvpJxtcL8BP1n9HBoyEr+Dhi9x5FeARPaNuwO5e
         yHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zBt/qZgsLXTMNMb03BartQTDgFJ4whNRfaR5h2RGGdA=;
        fh=rWdlZB2mgmkK3uUfQiq8wel7E1ZuXaS+VR146bTgbYA=;
        b=nw9itI50DcQ8IWAgouXAeb6MqsZm5ibhm8tf8PV38GB2ct7dBKYRJzEfXIKd71YfSL
         85dyh0LN4juSSJEWayoCqwbcHoP3RQBKy+Owm/mVlbcvp+uRHtaJtBnNKCbaOACvMink
         G3dtk8Kl8fZdeXMjdp1r2VMXSdIWFgTHz1Xo893SmUIU5HFr10DQFpzXtYKThpQl3Ce/
         2qyEHtZ7Cmduelx8zaCp1ON4IaY3DNPx4lyfZsuytykykf6ODNYochGva08H4cXRY+ep
         yfz2aVvng4DIGVCpbq0zG57NYMS54nyl7PkJZgOL+f3zA0Ng5+IdjeLB2+NK8Ufax6s7
         JGKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786505043; x=1787109843; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBt/qZgsLXTMNMb03BartQTDgFJ4whNRfaR5h2RGGdA=;
        b=kV/2LRTSbdbBxDNs1bLCyjdBWGMhnawOG6CDKgQLoN/4pMaImkYOv082HVAe2S3UEh
         9FKudCFR1o2FsN4+EwvFbe92iFXoza8XUfA6ac9E9z7dwQtZFXFidwcjsbOex13cNaVx
         c5UweBT+b/kidyUEIDFWAJfojNWVx/qcsi9ZnEbUg9s2aafpYhgWWd/U17XracF8Pcog
         JQoPqh9HJzXl9zhfQzI3TIGOE7BlGaFGObSVGaLTp++rzlZtFaD9Gku65B2jjdJKfe/+
         9F//IBcPwL7qqN6voRMfo1kEDczp5nVF5+wJWVIru5lpRDaCPcvM7A8yGXm+y92/o1e4
         Ze/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786505043; x=1787109843;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zBt/qZgsLXTMNMb03BartQTDgFJ4whNRfaR5h2RGGdA=;
        b=GMbCL7/hZ7zw3oGoCNaeuKUxQvQeuqcFkmQPWDfSb+QJTOwY7Erxc2AN+q841/morH
         a8dHFzdcMVQlcZFTpkgf7CV7p3vzKs3hT8UvLVb6uIO2Cm+/0HG5pCYAuymfihnFVUbl
         79NuHP17ZTYJZrXYdnGKvRpIMiWS/wInWEPbAJpj7HTaSkCnfVEU/93V+a12tv15uYeH
         ADZdUqsni8e5Ity86s0VaVbOVdgnuKNgldbesIjoG7h5mBqn8AJ7RgJZjc5he5mF6KFj
         tHEaxL38r5i+twzCpKkTRcKSK20fXkadYQe2NAsGo9tk5F22XQ4vSe2GkHGzplBD/aU4
         3UxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqe3l6ROh4D0duiZKRURKWEJW7EpaMh53kcyTuvb+LGVmBzjYzVdu4mEEWaHq7SKrXAR69S9gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHS0COKsKgldn8gKTfi9lh0xFtLmxRjO6RTHpsvPJVlMlejOe
	0CXYgMhfhVCGx8JndWK/6nJFz7wLvVLGck5dbelMrGtm8dUErRuWDub8bhFDwitem+tXkhNjuCy
	RFMeUyEzRy36wD2KIsWEIrlRXlwW9Y8g=
X-Gm-Gg: AR+sD11DwQcbbuES6Dhg/C5JTtHS/TuuRH3AYSSMglFdsKfU/58vJMKaSEQ3pv8V7cQ
	cxQAvJjNantYOh7x75vetg8tCQxiV5CzuIc1F73N1lpKYHhqu/5JfZ62cGqvsGvzlNOyJxif5a0
	PCRYR4mIvk32NGFYVihky4b8XKTjRWHqso/5s7oKnQM0xgVuHDuOQQxPlZv6fqPcUUi698LHUY+
	mhgj3INq2mvXHjaRH4SREqWd3fW6UIQFrVla5jeJ0PzWhG1mijuvaM+Hzo2RN1sB8OcHsgP3lb0
	aMfaFr05YZfdtnIT1elqsyjQlalQ1dVyiD4dzCi6StxRUfNCsCpJ7792UaOEFhrI/wunA2vvaaP
	t7WvoAF8NrKDfhsQuUofziiKT/o5xsGDoo4IwEcF1UbMS9Ik/U2iKavPlDJBk5p76FFzSPVFdxX
	0vE5bcHrxMbBF2
X-Received: by 2002:a05:690e:1914:b0:66a:c3aa:48ed with SMTP id
 956f58d0204a3-66b340e7a89mr968538d50.11.1786505042781; Tue, 11 Aug 2026
 20:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Colapietro <jasoncola1@gmail.com>
Date: Tue, 11 Aug 2026 23:23:51 -0400
X-Gm-Features: AUfX_mzugbBOicmHpKoAv3KhC9SvKN-FTdMJ313wWkPqNAHrREXbLVFbdiYcjgU
Message-ID: <CA+Z0x2L0udTqSZ=905W+oV5BSfsp7L+j7FJ5YnkoQPbQbjh7Mg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] usbip: make remote list honor parsable output
To: skhan@linuxfoundation.org, Shuah Khan <shuah@kernel.org>, 
	Valentina Manea <valentina.manea.m@gmail.com>
Cc: Hongren Zheng <i@zenithal.me>, Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 8/11/26 16:48, Shuah Khan wrote:
> What happens without this patch? Can you elaborate with some examples?

-p is accepted in every list mode and `usbip help list` documents it as
"Parsable list format", but it only ever reached the local (-l) and gadget
(-d) paths. list_exported_devices() never took the flag, so -r ignores it
and always prints the human-readable report.

That is what the reporter hit in bugzilla 219502 -- same flag, same command,
two different formats depending on -l vs -r:

[root@usb1 adminlocal]# /usr/sbin/usbip list -p -l
busid=1-2#usbid=1a86:55d4#
busid=2-1#usbid=0627:0001#
busid=2-3#usbid=11b0:6298#
busid=2-4#usbid=12d1:1506#
[root@usb1 adminlocal]# /usr/sbin/usbip list -p -r localhost
Exportable USB devices
======================
- localhost
2-3: ATECH FLASH TECHNOLOGY : Kingston SNA-DC/U (11b0:6298)
: /sys/devices/pci0000:00/0000:00:1d.7/usb2/2-3
: (Defined at Interface level) (00/00/00)

I reproduced that here: `usbip list -r <host>` and `usbip list -p -r <host>`
produce byte-identical output, so -p is a no-op on the one listing mode a
script is most likely to want it for. Automating attach against a remote host
means scraping the decorated report instead -- the column padding, the
" - <host>" banner, the blank line between devices, the per-interface lines.

After the patch, -r honours -p and emits the record shape local already uses:

$ usbip list -p -r 127.0.0.1
busid=1-1#usbid=0781:5583#
busid=1-2#usbid=046d:c52b#

so the obvious loop works against a remote host:

for b in $(usbip list -p -r "$host" | sed 's/^busid=//; s/#.*//'); do
usbip attach -r "$host" -b "$b"
done

On the same device set, `usbip list -p -l` and `usbip list -p -r <host>` are
now byte-identical -- one format for both sides.

Three things I checked:

- Without -p the remote output is unchanged; before and after diff clean.

- The connection stays in sync. Interface records are still read from the
socket in parsable mode, only the printf is suppressed. To confirm that
rather than assert it, I had the test server withhold the final 4-byte
usbip_usb_interface record for 3 seconds: the patched client with -p blocks
for the full 3 seconds, so it really is draining every record.

- With no exported devices, -p prints nothing on stdout ("no exportable
devices found on <host>" still goes to stderr), so stdout stays clean.

While checking that, I found the option order is a bug in its own right:
usbip_list() acts on -r, -l and -d the moment getopt_long() returns them, so
anything parsed afterwards is ignored. -p only works if it comes first --
"usbip list -r <host> -p" silently gives you the decorated report, and -l
and -d behave the same way. I have fixed that as a second patch in v3: the
mode is recorded during the option loop and run once parsing has finished,
so -p applies wherever it appears. When several mode selectors are given the
first one still wins, as before. Both orders and the long forms now produce
the same records, and the human output is untouched.

Testing disclosure: my checkout is on macOS, so I have not run a native
USB/IP stack end to end. The numbers above come from building the real
usbip_list.c, usbip_network.c, usbip_common.c and names.c against a stub
libudev -- the remote path never calls udev, and the stubs abort if reached
-- and pointing that binary at a small mock usbipd answering OP_REQ_DEVLIST
with a real OP_REP_DEVLIST payload. The -p -l side is a second build with a
fake udev backend presenting the same devices. So it is the real listing path
over a real socket, but not usbip-host/usbip-vudc on hardware. Happy to redo
the runs on a Linux box, or to have someone with a usbip setup confirm,
before this goes in.

I will send v3 as a two-patch series with a condensed before/after folded
into the first commit message, unless you would rather see the ordering fix
kept separate.

thanks,
Jason
