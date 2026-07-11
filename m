Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490825B0AB
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783779679; cv=none; b=XssDTauaWf1LfVwjwifvncmF1GCyFFd4ooHmWNlevaED5cnRcrSba85OCM7DDwJncucmwiAjH1pg6N8xTNpRR40an12A8iC6QtnojvU5rLee7Kjdv0HPiFz2URM6FixTXExNY2wHOzBNQ18j/MFCh/1FTfWhDKqBT0nb+RVfgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783779679; c=relaxed/simple;
	bh=GvFsq5AfQvOh2tzI2HINK80NO/HNxb+PL1nTi0jHfU4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XK+JrTP+d7ao31nafKHy+erAVNwo48VTkDSVj40L8pDKpQP0vYz8cyGkSzrzuAq+gGmneA+GILL2A8Aev4pBQ//egkR9NJr0hEmeYP1PVeg3gXPxhHd7aZMWau9AyG8v5cTndYcZM7nnjvv+j/eHPj/+qTyogKSq1gjLZHmRKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdhz9zbx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdhz9zbx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-470174001a0so1090256f8f.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783779677; x=1784384477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GvFsq5AfQvOh2tzI2HINK80NO/HNxb+PL1nTi0jHfU4=;
        b=bdhz9zbxZ6H0e6rNLnnMnosH+oa/Gssyb7/TpbUY/W/MujcKAfnOzcYDX1TOKbZ+9T
         nv1kwu8IYxE5W2GcT5Op8OYkR47h8gYCwlgrsgtRmt2lR9ob0uFPe3+leCsa45eV1n69
         nqkgitBbyf2+W3Fi7zdrPXkdAHg4YHqJROIeK/l6US3M7q5GfgW2bCWhaH/G8K74Jz0g
         pj+/u5paLI8p5Iv92S1ot7NuXqVzqngPuo9/08hbdI6S1eh4o60pw/ps0At54gAuuiC+
         FNHpjuHR2/v+DrfvzVxyQAHcK8r+hlziadOt2r4PUB0nWlV8HJqxbZa/7OC0jZBInj7U
         I2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783779677; x=1784384477;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvFsq5AfQvOh2tzI2HINK80NO/HNxb+PL1nTi0jHfU4=;
        b=Z5xVmYCj+iHJz9rIIGJpkFQQkWExf20CqJsypiQ6Y1mPi9/QTqAPgzvQP3qLxoF9O/
         v//nZIwfnqAf7CaALLnUgRtFyp5muDyYBd0PempFBf3QyJpIUzuWTkLKDCQwdnQ48zE4
         fIpHdJX1fEw0y/KyRZXsYtkV0fk0PyxAv7CEglKVhRZlvE4Y4b/NhJ3RRIBraiuvHnRx
         Sn6VY0rdLm1lO7PvywhSechOcRf7umJhZcPq14F1Wm8QTzP2IY8uhBAUH+55aa9YIE+f
         xSPxP52NCgKDi/55zfcvYGjNDKXBMIsdR5r6J33QDlgizwDNixkxy7v3amz6SoZPDMDq
         KzXw==
X-Gm-Message-State: AOJu0YzpzH0mD6BJosvrHj24gKBAbc/F4Ys1PNfOnsaqB3cSeZoM2ZAj
	R704GRm3rPnOg5enE11np+yU+lxGKkQhrOB5nAH4HoDV0z6eTKqA4H1QFFd+8Q==
X-Gm-Gg: AfdE7cknQaRwz5EOEayX047ETn4DV0B30eYh0omxQENLej6MYhAHzFhpWFI5SoFD4Qb
	XcZt6o6qHa/1sAhuG/bY5b4BJfKWrlySxKlvGE2CIjIxvj9HORPc4ci3aHB/F5V3/a8Vm/9N1cZ
	70zsbI1FZ4QfLNLLAyvRnNE+8HyKLizX8Aegqxor5FP9PSBuR4lfFlAGNnABLav/SZ8yz3WS3Q1
	I6bd725XjQm4tedjiHPc6WCZfhB0zGdciDfxbP1vaUUu5rUO+zWq2zE6eTbcB9+eM+LY+ZYAo5h
	S8el6F1RR7CY94PojSH7daXqCZF+DAhp1Q/UZMgyhLdGVRgAjO9dC8z7JiBlOf6eT4TAy8C++JN
	/hrILo5tugJjuUlHPtxMRKfBzxhEUt0lZUPz1cRW17lbikxTDq1KpOViMsfZCsQCI7h05VfuQpa
	WZwHr6zJGpS2/U8BENBW4a
X-Received: by 2002:a05:6000:470c:b0:47b:69a5:7243 with SMTP id ffacd0b85a97d-47f2dc8d6f7mr2946094f8f.12.1783779676698;
        Sat, 11 Jul 2026 07:21:16 -0700 (PDT)
Received: from [192.168.1.50] ([79.118.68.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm64498569f8f.35.2026.07.11.07.21.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 07:21:16 -0700 (PDT)
Message-ID: <083f380c-23e3-4a46-9885-085013371aee@gmail.com>
Date: Sat, 11 Jul 2026 17:21:15 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Please apply 63ccdfac8677 ("wifi: rtw89: correct drop logic for
 malformed AMPDU frames") to 7.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

rtw89 has a regression in 7.1: GTK rekeying can make the network
traffic stop. 63ccdfac8677 fixes that.

https://github.com/morrownr/rtw89/issues/109

Thanks.
