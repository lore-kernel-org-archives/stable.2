Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B27400E1A
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508826; cv=none; b=hP/BoH37qJ2ZxnXXSJOBTmUQ6YKuGF31A9ylBjzuW58GqZ3JMZjbJCb8hs2buuIs67hVxeDhOu4YMkMg1LTuIBxPJMiDcwjhqWefHX1tDY3jEMIZLc/1aqzmNVpPu9OLeqISujO2ivZwQcMBvHDojoo66N1aoB3pY8Abq8+NjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508826; c=relaxed/simple;
	bh=SWjs5dj3TCu3z/6b9bho/ZTJi29DUTPyt83vnmEXV+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH4k3xdeHziawOOAX0RePJnUP+s0h02aBD4HO60256QoDaZarPeHTxh1ACSsqkOeetfAlKfP8GQJA1UMq3UVM8/oP1b/lD08oBe6uy5o9TGfV6ChDhltzaWYUvWCgJvR4HR0mW+fVb2DTenCIwhDCwd/CXaXz4QILohU/BnKSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8TfB4lZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8TfB4lZ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1670dad7a8so142800266b.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785508823; x=1786113623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wGVPADeki+0/bIy545BYdtbcA87ECTF8VmVOWBf1hwc=;
        b=Y8TfB4lZ8beKQ9FQSX8NYBrFFlVJYmiPcdzMh7hy3QcuqOi+ug1woW6b/YvGtxrIMB
         btVAJecaEwJhoRF2u/xUlXRN92RkBnI+q0h0E8mUy4YrbYSbpwPaun9IZJIeOkJVN2BV
         VjW3XjoY8MpukRf8zbl22kjlTkH9YAXD/WudI1zZlP7C36a5QB3GQiGK/TKKQo4KP3iE
         95UJFQUEDc3zm82jKjb570iKmrByQqJlWghn9Qee96T+vPDttRWRu/DPnEkwcjZp+QvR
         DRWtrxOrPU2ak44QMzc8I/pSvC19DeL3X54DGo/lfRgciUuTre0/Tf8z4uGh5m8mp8xM
         lh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508823; x=1786113623;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGVPADeki+0/bIy545BYdtbcA87ECTF8VmVOWBf1hwc=;
        b=bFnnIZkEgdMC9iW5qJG6sDvj42G1uaYXvQSM3papyd2qBoye8TW/jzMY++A4ZI6bay
         EqoYD64t3Kv+o676WuuDW8Z8oT8J4RKjDl+IHFziOG3EicA4xNRT3n48+HwnvUH+Pcut
         SLxyLH07M+dX1SNhKbLPeQpk7Hz22XmdIGoEmZ4kIpIfiy0ZJqzclek4cbIpc7g0Wmv9
         NrMMT8NfcwtXtTgGMhcR2C3zWi3oUCmM7/RkqVwo6mqkxNDaw8DG6S2hUxPJHOcVvZwz
         fPUdrwW54OVj7ab1NLYpm+0EeI5mcE1qBtknDEzQNmM16RVdrpAsZ+/Zh53tZkm7E9n6
         3xow==
X-Forwarded-Encrypted: i=1; AHgh+RrNlcMY0AIMaNxSHJIn06Ah3cX9SDH8wc76fZHH/fvRUvFq8Nr1xPcjEu7dAzISyYmePk0iMNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7wTRc3qTav8+Gx3Ru861yco8T8OuISOrW6KyOsRoAGAPZCPq
	0/hpf1duT/aj8m6uR+msDO7ceCGPxQOZ/WZC0iBiBS4mCGXq3g0P73p4
X-Gm-Gg: AR+sD13Q/qD1imdskp+ZsVwAnBx83eS8WqNgz5OWAbpHyXLCpmHubQj05ueXmdCs/ZV
	+aDgZQy/b5PJSu79nq3ucVK9LuB0ME+Y6xv0TJjOgpxj/qIIUwR77jQ/QlIC2eOHwNaH7neTrQX
	wB+y89o+XF4dcIKemBWiwxpBriiT2EG6S9/hkVeqVdUxQfuPhDVbb8oLZ8iHfEEGlNGtX/4mEgl
	cjkvqbXl3OULnnp6MRLLanCyvGhp5mtJo3Lx0eksufySK1ozlQ5MuzXOrJN/gH9TBzGRDgq9/DQ
	FSpBjmBDJ6INijd/7Cn+ZsVq0VosOrMUTOmrHfUoi8IEnDtQGE6AtSbqJERQjzBAcV4hNbhsrxz
	wt6yB9x9gCvoD8NOgMu8EnZNdFkTe5+iCmgfmi6+N8iqNA1RQKlvY6z6TRs8XfKRc8skfST9sl9
	nrizy3H4Txg9wiP1L35Krn5wntwXOE6MQ+W8KCr2z7aE3bzTT7dPbz6/KoJWdYpXRLQnqijuCvE
	oTAUJmboCvrspW5pYbVRDUHdsIXP8Yq7clqdgSUTDUcdA045GlMrSFv/5PG9qaJyezcYLvoN/M8
	qQnXOdimebEL0JDJ2Ra8ox8p6L+eoMqgPPUP5Zgd/0CGFdSuYqWJINv22sWwWspn3UIG5qw=
X-Received: by 2002:a17:907:d08e:b0:c16:6e45:5ba7 with SMTP id a640c23a62f3a-c1fd271cb9fmr136450466b.59.1785508823290;
        Fri, 31 Jul 2026 07:40:23 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4453823sm185693866b.40.2026.07.31.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:40:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:40:21 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <amyxxce6haNJBJ3G@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-5-kmehltretter@gmail.com>
 <amufrR-1hop2pZOz@SMW015318>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amufrR-1hop2pZOz@SMW015318>

On Thu, Jul 30, 2026 at 02:02:05PM +0100, Frank Li wrote:
> imx_uart_remove()
> {
> 	imx_uart_ports[line] = NULL;
> 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> }
> 
> Is above sequence to avoid use mutex?
> 

I now tried this, but it doesn't work as-is:

uart_add_one_port() may call imx_uart_console_setup(), so the entry
must be present before the call.

uart_remove_one_port() unregisters the console. Clearing the entry first
causes its callbacks to dereference NULL.

The mutex protects those sequences against sibling probes.

Thanks,
Karl
