Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180183;
	b=oIrnPOMlY7tquhPVqU0nm2Qi9Ot0cbUQ6LclqMGRC0+QdmvaCl2BNGBJB+WaCiUsb9Bm
	 P/qg0vuCDcpG2JtszM8bLmNscd3MqTXs/LG2b4Mi9hk/STd3l9QGGjab5O2ajf2YC8L/+
	 gstyIbIppQAQipxkOzfh3Mhns08XnPO9SwvwThj3ZSC7QIKH2BCpy65QI3KRHLBpDct5t
	 SuVCEPCNIoxl0rgKVfD433JgCtoayiH3Wy9TUAbJsWvOhQo4Q8WkqwNpavqXFC8bfKrzM
	 QeWrxXX9aFgJAuwqj58IJn0ttRdEvKq98HPp1fUtWNKHbXomZqqTbnZDUB+aOJTQ70Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RasCjunpCh/NnC9QmLv8I/gSUP58pKx7xFWImX02RhM=;
	b=0AGX2865OyloskbJ17LQOmORaLMnErq+d6YBQ88XVe/IO0srAfIC0P77HjB1q6nts+B2
	 cezhmZnZlskzO1S4NduM0mUUwjtNBkbHQ8LGLZWZmnMIhmwaNhtg66J9EteL6wXPhiXF/
	 54iH7B0WpomfYGKioBdcWwMQrhMdRXgAklsluF2NN+alU7RCM5wyAX6fvnpxYOKBsHDVu
	 bwPzvy4P9uDTUgrY2LP/NPSVDdHZL5ZqAR2O7lLI/414ThkybuOBo3U0AmgxMlv/tKfdY
	 95Sa/mVz5YHy5lsb9vpUcn34KXst5djW4QnwR4d3It7NgfG/+7QJsJdV2eIRB+AH8nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IO5fdKi4;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B41606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B41606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IO5fdKi4
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso6110565e9.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180181; x=1793784981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RasCjunpCh/NnC9QmLv8I/gSUP58pKx7xFWImX02RhM=;
        b=IO5fdKi4z0OLJU7M88/lVVb6oujx+gY8duIyBx8erfI51FuYBuaXd1yPV1ZBI7NoOg
         cFY0Q9LmITOxTsPeS93gOoaQMCziY4PA+/tncE48IFF9LRHTnwxXwMQSi1gc07DrcAbi
         +US+GjuAJFUTxb7VS9qX69A4UheQ8Tgm1cVq+w8nMetORtjcvnGD62cFm6SRwrBbCKL1
         g9UzJ8T5x2+Vtp4TIh5aYPMoUosdmIv3WRAbx8W3euHH7pulvB1/YJ6i8Awr7pYR/oHe
         c4lRhn/5iZk5jZALIdNkyQ6p7gvoh5Qy/qH+OqYHc3QhTOdURJfLl3LX214CvBTHizv1
         US5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180181; x=1793784981;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RasCjunpCh/NnC9QmLv8I/gSUP58pKx7xFWImX02RhM=;
        b=jeh6YYB0aYtgIqSi0RD/oUIFD0rD8GIRUBcaQC6Nupuv7uSh2I6rRxk9JnD9riz1rd
         5m0TSNEe/XV5dxNMkfsdqY4EfegqpSqLBSMfDI3xdfh/STixt/JjcWebOAjauuU+hooB
         7GUSLRw8jkoSaaYvn8mpob/KPWv4O9F5FA5QIODzNgPaX+4D7qw1q7IzNgDLZdqFkqad
         MAdlm4UX4ACc2hmTse3efCBXAeq8DS1vnV/1SQyqn+w04SIrHvi/hhNzp/i0snG+uTKj
         BDYrKluc0ArFbZwnO5JqGdDiuJxXz+y37gMH/AGs+rhP2hl7AbjORg8hTLmuAo1agw6S
         bsMw==
X-Forwarded-Encrypted: i=1; AKwUvBzzLiwaMHlwMHW3vspue+DePZax2eNwTtPNhsXhy1YqmgzBcI9ifYwdbiTzWR0vAP//affDAxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1zIhMIX8ZfxxNPB0h39q918ZATIsoSehl0mc5dTEpbQ/qThU6
	Sn1KyN6kBeo7aE3OatB4rL34XQJb10KO4lcQ8bpZoisdkJudY9AUcXNd
X-Gm-Gg: AYBFou2fuCnMVoaaFMviZiLxt6B+2+F+mUHp1okERSyv7D0scvsU9lUExHtBmhxYw+/
	4dZe1PrRy8SwrfG1wS0PlcMfTB9BK6rXQ1RlJcKZ35J39c3iRPEs2OM0b2pVRLkQY0K9eyxsN3F
	LRWm/9aXT8/mzxPoQYlEAE31iRWjWeP+AwqM0mvu2Hdh0Vio9QmPYR+ztcygj5QNhnwhrEwI1Sn
	kXi1v2+TkbP6fs9dqraBA3tGDhItOkGUb/n/qBSwWc5NNBjICxcAk+nG9b5QpJ59zG+oYOtEX6/
	UAsAK+gvZXJKcRy4l4mMTCE3Y9AaGkoKPM7U0kwD6JmvDQssuzZf8sSGpkcI2tbBjlI3lY1y9B5
	3qQfgLyc5mxbt7YLXaTpfpJTblFGH+u+u/qWINaD/MX+QgNSLVgaU6EAilNaImfbtbmGp59YWHv
	Q/iLTqHKAfpuleier7wZdrLvUsA8IgKttW3k0qgHtG66VFx5V1Xq0moIYopPD9+AMrWFMrklem/
	7Z2PDSDTqWGg0IUjvh2EitOhcLkyDdGc8O+UWoe3+XEzEsIwopTYBGZFOtlGNAijkidTR9KLfo9
	0CqyaapwtR64wSKPdU0Z73KDToCvpVKEAIU7+g==
X-Received: by 2002:a05:600c:609b:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4a965ec941cmr33454985e9.7.1793180180835;
        Wed, 28 Oct 2026 02:36:20 -0700 (PDT)
Received: from foxbook (bgu81.neoplus.adsl.tpnet.pl. [83.28.84.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9ead8aa0fsm5886335e9.4.2026.10.28.02.36.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Oct 2026 02:36:20 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:36:16 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: wenxiong@linux.ibm.com, mathias.nyman@intel.com, Bjorn Helgaas
 <bhelgaas@google.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, wenxiong@us.ibm.com,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V3] xhci: Reset TI USB controller on xhci shutdown
Message-ID: <20261028103616.29110069.michal.pecio@gmail.com>
In-Reply-To: <20261021160608.8229-1-wenxiong@linux.ibm.com>
References: <20261021160608.8229-1-wenxiong@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 12:06:08 -0400, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Fixes kexec boot. Without a hard reset, TI pci usb chips will fail to
> initialize in a kexec booted kernel.
> 
> Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>

[ Adding linux-pci and Bjorn Helgaas ]

I tried to make this code a bit more "proper", by moving the
pci_reset_function_locked() call to xhci-pci.c from xhci.c.

I found that when I actually run this, I get a warning from PCI:

  unlocked secondary bus reset via: __pci_reset_function_locked

Bjorn, any tips what would be a proper way to whack a malfunctioning
PCI device with a heavy hammer to ensure it will work after kexec?
Seems we have pci_reset_function(), which locks the parent bridge for
us, but it also preserves some "state". Do we want that?

I'm also starting to wonder if we shouldn't do this reset after kexec,
to cover for kdump. Or maybe both, because shutdown() is supposed to
quiesce the chip and keep it from doing DMA, and we have no idea what
such chip is doing (if anything) when it refuses to halt.

Thanks,
Michal

> [...]
> +	/*
> +	 * TI xHCI controllers fail to initialize in a kexec
> +	 * kernel without a PCI function reset
> +	 */
> +	if (err && (xhci->quirks & XHCI_RESET_ON_SHUTDOWN))
> +		pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
> [...]
