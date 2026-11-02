Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589534;
	b=vl8HtHHO4acWCZQffv4lYH55gqBr0ivEFwbzH/6gUbBX15hKlQrtZltAhm9HUUnIqTF6
	 MNZlGiHdL+CMZLlXtvbxv8vLQpzRwWbHDL2iFw8xHzeb8lu7DIUzdsAY+JEFopojPGsiC
	 RkjRyDeyIlZor9bDUpFTGicKFIY8g4HJI3blg95ng8D0anVD6UI/uJTL39JGs0UqF5eqL
	 Wap3GeDphr58x6c13Bvsc0Ew3Xfwd940Wuw70MD+eF6gDbioM6qMhcV9cYM4K4wFIT0r1
	 hdnrrhAwSvv/bvJe+Ss+BV0CJi4BP/EDGuNaNCs3i9PtFEo5D8kVnUFB3GRHmVddV2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=nJCnzPlEYPTpiPpNwhFLsc1nTWFuyJzYXd5f4tSr6oQ=;
	b=IF3ZzLEJ8tEYW0xKCEZBeO2g6Oj3pt7hDLPt0RMQthi3O5+w+exWEFBgYLBkKv1jMLmh
	 f/DwlhEQ1EUUS5Xr23L02XDitt5WA829XMMBCkAtXKbZs5ywgUgAUtbunrjsqowiYhe5R
	 o/Do/IpB47F+OVmXetFEEbrdhwEWdQkFci2f6DJMUHscwsx3NJvBzChya2CMu8MygOa1b
	 2Ag2adlsCEPIWADOl+zH/K8Un7xn1YjQUrdhJ3+bdCGTxi8Dwso1wDc0tLw1i9+wqoQbn
	 FsUPFxANFCDzOajFmOC0e0LPGqbezoEDxX36Pm5XGRAHguw5bxN3G+GXQqX/oUrqbEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzdV9ohT;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE1606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 03:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BDE1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HzdV9ohT
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so3838641eec.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 19:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793589533; x=1794194333; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJCnzPlEYPTpiPpNwhFLsc1nTWFuyJzYXd5f4tSr6oQ=;
        b=HzdV9ohTmNFyqmLLsDCqmODyoy6Sx31mv0ijemiLjdQg7hHw0X40I2CBE+mz0w6uWC
         aNYtC6Yu5CBBGxnEVhvE/Y4P6wEZVejk2WgvWSIhziXfRTXvLOnmEUo9UxTr7iP4XE/3
         2eEplDFJDBFyraV/0AW3CWGNlYcrVqQIpT2k2nOGcHrMMk5JghogbQjvZYX+UKpoAakp
         Y1Cxg2O0X+lnxVEt7t0wL7ZtoESdT4GuM4+mampJwV4M+gY1pIlnVR9DJfvSBaw9QIpW
         NQcWRXEroXcZLMc6vUr7ZvMWPYeFlup5uPOXrbCj0dmNQE52XCFrdmOQbDZhTClfxJTa
         y+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793589533; x=1794194333;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJCnzPlEYPTpiPpNwhFLsc1nTWFuyJzYXd5f4tSr6oQ=;
        b=imDRnYW0MOiEaFYlK3/LOvF5KUlGb1bGgWXFTYhZyaoljX3XsLuFexLuRAOI2yMQ+d
         PaoYrY8W/0IcwdosvUnHSJZXumoZ7MFhnYMXEzS6HxZB1pBdqyOoBezPCJEQqyE+IS3y
         LtGqYB5k/Oq3XjuSylpQ839V/4W/BFrEDgM+93xnCaupWVF1jzbGi1HibO9wirt+MRvm
         a7gK8sierznZB1WwyihTVy/k6/jC62PEULiG4NEZzRNn5TywG7YXedPdy/+DX/O6Dpsg
         FtlQiPrtzoK5cfM16n24fN7DmNugHBb4Xrzh0MazhM0EDG9bHqt0i762yJ1RjwLkO9/7
         1OiA==
X-Forwarded-Encrypted: i=1; AKwUvBys/GwuTtTdyirRi68jrAaUNJMoXqAOWu1MbdS6vo3VkW9RCpgCJ/BELUNpDC3G375g4OeW5uw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KAk8T1XqZ6XAIEek4RaQv6Z1SD47eGe433Occ7ik80JYn/irV
	yV5yVrQ/EOBpMBdtrYdRgdYjM0zeeCTppMbibLGNaMJElDSdNlXkdzoU
X-Gm-Gg: AYBFou1WGGqFEe6/VlxqF+b4CQv09XgoT9Aj9lC6kuIqxrDGjG/Y7zzyG5+CqqFmq5H
	gwzOYjjD9GRg/eSuEulUsTpAN6TaQb3SaG5H7Z0NdwK2DVGHSgQSSaCQtWPbmvCkFCBuOB4i0TW
	rmtYXYgpvYcix00XwbXI/1xtwjBQVWcebDwEd4Dsj+/LrATwtGXlznlIxWi9FJW6m3Xt9afjxzl
	rvnI0FxhV35f2g1izLUGBP9cYpqVWKQ18IrIXaKFHTsRws+x/62ly7EwdFHgqUgAgjnPr+Ab0o5
	QSJ7WQQwFM/gMjeb2isZDBRf9GUSFUK/wV9OgCYl+pzjPpY4S+QZSb4UTKsmCOKG0+y4Z9jJSxB
	rJmxD+UvmJ0X5vKnbVtQheouJUJbDpkFWTqWC1mafEPp8wNfrmi+84v1WY08bHivkLg1EWPBfr/
	ZoDKLY6siO4tBdROxXG7Tau2zTwqxUE96pAkT1VvhwXL7rQ+itl6hzzH661dDz+JYqyRaTjBFsO
	wPJyC6JldzC6Lp3V28qgFpDzV56VoyzSRwEICARqev3IGNzEXjVTrBUX1PnFvEZt4NYgZDg05W+
	mXs6Rf9PkNW9y2EkwCRWimm9J6tsfiIkyPpWqLiLne/NWMrYxCLD8KdQjTrhbv05/2C5pPM=
X-Received: by 2002:a05:693c:20d0:20b0:36a:112d:fae3 with SMTP id 5a478bee46e88-36a42435927mr13964731eec.40.1793589533040;
        Sun, 01 Nov 2026 19:18:53 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:d75c:a9d8:6c00:c5c6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm33411882eec.24.2026.11.01.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 19:18:52 -0800 (PST)
Date: Sun, 01 Nov 2026 19:18:51 -0800
Message-ID: <4590302cb7f26ea6173018f5d7083977@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Petr Hodina <petr.hodina@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	phone-devel@vger.kernel.org,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v8 0/5] Input: support for STM FTS5
In-Reply-To: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi David,

On Fri, Sep 25, 2026 at 11:22:18PM +0200, David Heidelberg wrote:
> Used on various phones. Minimal viable driver.
>
> Includes device-tree enabling touchscreen on Pixel 3.
> Also, tested on Xiaomi Mi 8 (device-tree is not yet inside the mainline).

I applied patches 1 through 4 (leaving patch 5/5 for the Qualcomm SoC
tree) with a few small adjustments folded in:

 - In patch 1/5, added a missing trailing newline to the reset timeout
   error message and fixed a typo in the comment in stmfts_power_on().
 - In patch 3/5, wrapped "const: st,stmfts5" under "contains:" in the
   allOf condition so the check keeps working if a fallback compatible
   is added later.
 - In patch 4/5:
   - moved ABS_MT_TOOL_TYPE setup from stmfts_setup_input() to
     stmfts5_setup_input() since FTS4 does not report tool types;
   - dropped the undocumented "stylus-enabled" property check so stylus
     contacts unconditionally report MT_TOOL_PEN;
   - checked X and Y resolutions independently before applying the
     10 units/mm fallback;
   - added a check for !sdata->ops in stmfts_probe();
   - fixed the GPIO name in the "mode-switch" error message and a couple
     of minor comment/log formatting nits.

I will also send out a few separate follow-up patches shortly: one
teaching touchscreen_parse_properties() to parse touchscreen-x-mm and
touchscreen-y-mm directly so drivers do not have to open-code resolution
handling, plus a few fixes in stmfts (not aborting FIFO parsing early on
non-touch events, validating the 4-bit slot ID against
STMFTS_MAX_FINGERS, and switching coordinate reporting to
touchscreen_report_pos() so axis inversion and swapping properties are
honored).

Thanks.

-- 
Dmitry
