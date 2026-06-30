Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE513DB33C
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839449; cv=pass; b=TInjQcblNl5b/nFyZ+YHWFILvjGpKeBCrKUR3qtal6KCYIml6WqPDwUgO+SPzD/t95O+dDL4H8XjtrZgLvruVRSSc9syIdz708ig2psZXY+s4p097OYUQbosxpIUh2XACNZmJLACjjKPcH2XElN3BSVtWLoJDmUkq5LpV3X4eTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839449; c=relaxed/simple;
	bh=Q+NKeElSU3Mey9uyDYNttOsH+dbdUz4bwovoPjDwSTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMX2scsTgR0tylcjZRECY6zLp2ABtNlyxl+6FSm3pGbqo5kF2i2frMv4Ol4odUu0ZhPLl8MQKacPuP1d5IyIPrGO1cSBXxLbHtvh80QT90+oVrqVhhRoOrV/GeLxpKfSHYNPH+49JSjlAMeYG2gOii9AqrmCYq1BD8Jn0yzmzoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD0UN9K0; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD0UN9K0"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c124c3c876aso517216766b.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782839446; cv=none;
        d=google.com; s=arc-20260327;
        b=QCAw9e7Sxs2xdkdwqdjRpYDPjWoUTAOkDVc2AYVC/FoHokAbJC+Wi+3Yjq4ZifLNzg
         Ni8uDppTIBN8wCQUhCruikYE8B11BCO+IRPi/PzW8k7eK0iJ2oB9cpz/YfC/NtnY9Xni
         RppMlMA0G+1PuRMgifs285BFAs6N0ImGNY8Zq0ffhsMU0DKOOFG+dLBX24dv/KUqarCF
         m1g9HsTYp5zf3yR8ZLh30KT0onTF4bJIYyxs+ZjYvQj8tU3UHEc2ktTlqSZ5R/Ca45Hr
         /V9XtdwgNwuylw+1tWWqzpnDsWrlMLH4orCIy6/RUh25/wX8W23y3OqZB9R729yHbJSz
         ssHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=64A1s13t8IpGGSBhMh8O8eYrTFpABwP1rR+WIQ9DsoI=;
        fh=0djsQ4HX0dTcCdxSZe5mJ+IuddEFhc2vjvXU+GHzGzw=;
        b=oveKp0S2tCMAaJP/nCbQn+4yvtD4nuxuoZCWIyL8WLywsxdu4MSbf7RwPELAW9nDIn
         ROSXbBNwdYTT3MXD0uu1I0wyXVa5KVU1hwoe3IHlAwYaMbj25uzyTxL3RXlY8U+lz/jL
         hGkn/YLnS+oOvBvfusv8O1IjPPTep4GsT+/y5+L22UD+3LdFTn7vr1w35t/hwptrv8v5
         YKndWUrsukcOSsV6V5wzQTOnck3t8TIvtRaQ9e0QAlRiAULgNQ/1tjFXPwkUBr8VLAQ0
         ZvPHDEKc8hoR29n1ICSJD7+diSRiMzkcZFZO8JoIDVtt7JMCCtDO8i1npvBnGmtbFkJb
         VNGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782839446; x=1783444246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=64A1s13t8IpGGSBhMh8O8eYrTFpABwP1rR+WIQ9DsoI=;
        b=aD0UN9K0I2je6VboJYEwgYK/1RyEHdtZCobpZKj1h227f+0T94gqS5Uu2Z6SxTLT/s
         PFX1n5ScwuxOhL0q5YiTfGIy4PjNbSi9lZr348jFAwbRvO/KMTTe6v7VVTYV1YUbm9UG
         Lj1gnmQyJjV2zBkY2fbKjQg6ZDVv3KA6l/fukd/sHKRYMV/Kn9yXshmkW9JgiYpb2+/i
         ZlA3uU/nxcw7IDniepvYdidEtkgqB1m5UNzSZ9uN7hYKpuccCybt0uRnSSMUdf6iTlHE
         sOrbJLR3YtoaZNa/jBiDHXnf8Mw1x9VumT1EU+4EofBM+/J9/kDQt3PDhtgvHDr2KAiA
         m2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839446; x=1783444246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64A1s13t8IpGGSBhMh8O8eYrTFpABwP1rR+WIQ9DsoI=;
        b=MBupvqKPF4nWdlvBUVbLFrLte3eM3oSOy2yDqU09RbDYHhDViaSmEIQusoS1XC1e/m
         hK8oXvzi4t/TnhOsuRt5Py/WFPhQecSO33bapnYfz5i/vGlSwLHV8z27QPoJOMT4GgbI
         vnz8LjNKlvlVHu9fGmkGeDeWSCjxnYeMvqVOOrKRNWaDBiId4wrwOpoC9iXG7JjtL2NV
         TuoBYL6SoINQSMafxcROzKI0GIqF0cY2QbzNWbAm8YUrrOZ/kP7reI3H+PfFGyfccaH/
         EGg3Ae8WsIBsY30exVfeqZID+XXIbWFWbHWG7zrKAA2hHBXl6wcuXR8ez0QqVOv24Guz
         MxLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrygmpwQcWTd31dEFcItW+uZG9k/ATyQTGQ3xWiSPZtbDTsdKvbI1btC7tsdB559nokPVMq6ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMpcDdoQ+MKKpNnz1ghxz5MuPh+kS+EC8Q5LYmVMo9w5j+FgKX
	LG9lm8FgtMcQxQLoP+e/4r/lAqgKU3TT2c7MrjVO0DmOSE9yI2fy0iTfc0MYBXRpFe8z5S+PALs
	vwOuE+5nyhZ2eNT1orJnP9vxruD8baPQ=
X-Gm-Gg: AfdE7cmx7H0HmJDsDZyofGw2jGVFmxNDTNKDeZw5/KsxOmxrN+WHBxICgYgyPWXj5Q9
	mn9wg6uATPd8OkeuvtQoiFdFao9d3WEcdV0FFNEGYj5K05PUlbauBKD1gH83aHQaUU8XqJPyx7h
	RM8sqCulbJcRKE28hE2HxxeXOrA7Z9Q0LzRExnyX64+SDFqyg1SCOlo/RctEXoeoyISjqJJzl1V
	w6qoFVn3rGUMuiL9niegB9xBFVSlOu6mynkdstW46EWfZi2H92BvsweZ+bqhYe0FV3ZvmS5sG+T
	Ivv+d+tWKo7VmHjBToklBpay8fCuB0o=
X-Received: by 2002:a17:906:6a84:b0:c12:8296:1a76 with SMTP id
 a640c23a62f3a-c12872d6ec8mr174161766b.33.1782839445331; Tue, 30 Jun 2026
 10:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <20260628231634.6752f74d.michal.pecio@gmail.com> <CAFgddh+AUNH9Ji-Qd=BKEDZWJrzPMWN20-g-htQDPSdSehZStQ@mail.gmail.com>
 <e7d49127-0215-4b29-9a2a-e1dc0d889b70@rowland.harvard.edu>
In-Reply-To: <e7d49127-0215-4b29-9a2a-e1dc0d889b70@rowland.harvard.edu>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Tue, 30 Jun 2026 22:40:33 +0530
X-Gm-Features: AVVi8CfKnnvidb5guFAdpaAe6CVJqAOJJ5DDmKL1Krrb-F8QVvOrevg30QCfF0c
Message-ID: <CAFgddhLeQ1cJv-E4mYWR8cs7T2USkrEd5i=uxqkNCH2UWaQ5=g@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Michal Pecio <michal.pecio@gmail.com>, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> There's nothing wrong with trusting the caller to do the right thing.
> Besides, if a segfault does occur then it will be pretty obvious that
> the caller needs to be fixed.
>
> What would you do if buf is NULL?  Return an error code?  That won't
> help anyone locate the bug.  Put an error message in the log?  Segfaults
> are much more visible.

Understood. I guess my coding style is a little "too paranoid" and
"check everything and report errors". I understood now why this may
not always be the best approach in low level programming like kernel
development.

Anyways, I have done all the requested changes. Here's a short summary:
- put strings in a single line
- copy bytes from desc to bigbuffer instead of pointer aliasing. (so
no krealloc too)
- change tabs to spaces in documentation
- reworded some comments
- drop USB_CONFIG_WINDOWS_REQ_SIZE macro
- revert USB_DELAY_INIT to original behavior. no delay before 1st request.

Let me know if I missed any changes mentioned in previous discussions
(or misunderstood and made unnecessary changes :') ).

> I wonder if it wouldn't make sense to split announce_device() so that
> the first line is printed as soon as usb_new_device() starts, before
> enumeration is attempted and possibly fails.

The current patch still logs device ids upon failure in
usb_enumerate_device(). Do you want me to implement that suggestion?

Thanks,
Nikhil Solanke
