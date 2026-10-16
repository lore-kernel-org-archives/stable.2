Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816E51FCC6
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175238; cv=none; b=vEGdwdI0rSVuaJbRMtt+sCS757w5RY2TWJCws2iQKtv/Yi1k6hzY3PZeQ77JupPx7LHvJVfr7Kz1H5o0WLBmv9jdIP6OhnfddXpFb2RRO8DdEptD3sQepaDGpQtR+DROa/ysHDUmuaz2d7DHpNKADO3WmWA2/WoTKMOvab0CX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175238; c=relaxed/simple;
	bh=VBRTXcwLrUGeAqqGUzuYSNaXljshwUPb5DPEUQUp/Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg8HFbaTjmooQrfYox74ZiAozIHmd0ovYtLUr1PNTPqiLDv7hEwvrt1LpWDrjD0QFxDgaToQ05SJfK5EiGYXTLmMjQDXAsOq/kmuNNAgKdIObBg2kiVU5NBsIkWTUCbdM94JluIm4egZXNaZaWmeMex1xDMCXJ4nfx4ns4fUh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwWC6Y4B; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwWC6Y4B"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514b90bb89so441202eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792175236; x=1792780036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNlQS2xn23EOx0Q7AzOrXy24hZ0s1Lyk3n6Wb6L7jSY=;
        b=rwWC6Y4B/9PWtrSHtB2Z0NelkjCd55vBJnNfs7yg2s8FWuedT4mR5Af7ruOn0ma4Ho
         Ks9oWtUUmZmrVtjyjuoauG5l9nQvn0svES7w8M5VNzLb0YocaY0id60rFRQKRU7JnJOY
         qN7eG/vO77ohnH2CCE4bZOzxg82T+kAEsUHhdE7L1pXGW4i7Wv61WX4z62fHbIyhNByG
         AmjBsxV6iNV+++yesLBkq4QMApMjbkmv/owVTH994wc5W/vXlPgdcUuU94r3TvRE4qTa
         M/dcMWIsunQsWP/G2H5qZFXDjwf0TCKuT1vfDBk09i37C5/ZaphWzSgy9XoZgeAeZIqa
         IT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792175236; x=1792780036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNlQS2xn23EOx0Q7AzOrXy24hZ0s1Lyk3n6Wb6L7jSY=;
        b=UMk7KeyqBWa6jyZW0n69UaVpF6eGYNkvJ0vimZgwB435HUOiiqiDjf452+nPNAWCX5
         6CeQupFmfMIFiMlK6jQbeEMilj3CuDalEVEf1GuG9ERT9xxFwKhM4Z/gMo34rPnHlPYE
         LvJVPz7/zRSA4iz/lOPUEwF7kPnlqgIPfP5iBtBuQOL0czQPhI+CJDndwupf9XgNr+YK
         3p3u2JBZzAky6SeZtzF2hvYlSOb/BVxNryEkQjIsqrEv7jafeZ5hvLfrkKLdqvxyQ8y5
         bd5fhDDZfAc5CXfZdfIoXJvgDzdPzYZuvnTgSDZtSgUXRAp7YOmrZX1KKQXwHowJl6fD
         VBaw==
X-Forwarded-Encrypted: i=1; AKwUvBzKaUalzxq5gI8yPcVtKxJZsGpU5UxLd+0c03dJeFE5BtosNNJEAFs0znehWZ5HDca2RYexx4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6aMStatNHiwKTFpchWAjNOSefimxbOJNPby6JmXFlSZA2v79o
	8qbVKgPk8D1NwTgt7muqBrXwO+Mi1DqMI4sYo7pOPsqF0kzqemnCP8TNd91Brw==
X-Gm-Gg: AYBFou13zoiT9aYkbW3mSFpuST66YrAobNZo0CBJ/YUnrJz80Ea4uFTyMNjiS3xQjy9
	955T9Nk6gVbRO2qXgQmPBB5IUAubgF9yKURwRifT+KT4h3gWpF2scY9MjsK099zMdsQiGcu7rpO
	w9hV2YLDX0/pQ+DZbIAQYCgZeMeuCdtEa6Lu1YbVl1K8S9fE8en36OuUvN3A2IfHK+AbDLPZRDj
	CbFoXNjKoew/RDn2i5Qc08n7GZ1Q7+oqjaorEFcw6u6PrKRbvxRXfyd8mWaOqR4VJu+hTETS/BZ
	NbbTP+hkSRvY80VcISFaPXwxAm2limvaFid6KvPRYM6B0C+zlGRpT3Ru3Lpt9RTfiPYc/+8c9F4
	roBCjfS71yrIQf7eeX+8lVUsaIlVP2wLN2CNKdVy7MXIIWoLz4xeGKQ6kiUZ6G08kDZvF0O6Stn
	FAWwBPVT9sqA3Hkd2OE+ZNcSZmdZhHmKfx8BvbEmsCP8EzHqeSPb1cKGRRI4X0+lpYWIhtDRxXe
	LEsfhOyczi5B4lu57LSNqhdhSh3WayrrIfdJ/CR
X-Received: by 2002:a05:701b:2608:b0:182:9071:3249 with SMTP id a92af1059eb24-185131076f4mr716375c88.30.1792175235936;
        Fri, 16 Oct 2026 11:27:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e6ab:aea2:fd2a:caf4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm6670161c88.20.2026.10.16.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:27:15 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:27:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 2/2] HID: multitouch: fix use-after-free of haptic
 data on delayed input release
Message-ID: <atJrRjjgXZz5A-Lq@google.com>
References: <20261016163349.3293666-1-qwe.aldo@gmail.com>
 <20261016173056.3397211-1-qwe.aldo@gmail.com>
 <20261016173056.3397211-3-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016173056.3397211-3-qwe.aldo@gmail.com>

On Fri, Oct 16, 2026 at 02:30:56PM -0300, Aldo Ariel Panzardo wrote:
> mt_probe() allocates td->haptic with devm_kzalloc() and hid_haptic_init()
> stores it in ff->private.  When the HID device is removed while an evdev
> fd is still held, devres frees td->haptic at unbind but
> hid_haptic_destroy() runs later from input_dev_release() and dereferences
> the freed pointer.  input_ff_destroy() then double-frees it via
> kfree(ff->private).

Right, so that is the root of the problem. We should not be allocating
memory assigned to ff->private with devm as its lifetime is not directly
tied to the time when device is bound to a driver.

Your initial approach was correct one. 

Thanks.

-- 
Dmitry
