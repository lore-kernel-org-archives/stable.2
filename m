Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD1375AC6
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513251; cv=pass; b=N9CW+S+k5co7XRYmUHybfo2aAueS/5koFQKhvqh47vhBfYnLDK5sqZEY/DgDHaff2ApMThPY3ty0Di7LGPU/4O1NnfAqHvQV8h79R90umFZdWJ1nxROxU3QbnSIN8HVsaA3oDIWS/NFWIDIhf50LCE/CbNr9psXMNdnfPjRdlPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513251; c=relaxed/simple;
	bh=m/seKxW02ByOnB0+QTpdy9uY3bXNt5eyT11VbzK816s=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNGWxPIQi3naWgS9BeHl+P5yj4tq0zRZ9fKtztUVNymr5KhXI5i+7aU/Xm0PjTLF5R5iTtNOXKEx8/Fxz3t3VZAhe1h3bgKPt3+wpn8PoO3bIAPup9RNBXEwpeIefsCBM4qYp0q5oUTNHTlELc1hA91gHGz5OP1VSMu3LZvjM4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz2Z6J8I; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz2Z6J8I"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66843304cbaso733947d50.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 22:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786513248; cv=none;
        d=google.com; s=arc-20260327;
        b=rWJUFYQUhnKz/0T9JqOr7mtcT+RRa7L09/If2q4UFCJl8rhDkenkfExcpGfOYsGSna
         +wYTpl8Pqc9qXLs4Uf/Z17sHcvuskpndy0RQMFTpRLdhvJmp5wFZZYxqfgXBLx3Q09oS
         LO/GnJYeiS/t6rxz1FEDv5qySbHe/CNHT73UAMTWfb4zr8G2Mjl8F1K8cED12bXkppu0
         W2wKcnQOqhfcCNiXD0+tJkfCtHwM3E2RebReD4qDWz0Eh1y2FptMdBZjZJSb3M5Yf/Ha
         OzbJC7dwllcS+ZximB5746cZLqx8D8V6RLe6H/9IjUvzMShjx34IawK/xETRPoaJjkh/
         bJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=m/seKxW02ByOnB0+QTpdy9uY3bXNt5eyT11VbzK816s=;
        fh=cNN9BCoZ74WTtjZ6vA99RIqsbmti6Z3QMNNKHueKXbQ=;
        b=oLlJsuJfXvB4qoRfuHMgImqeHkA9TpMlV8IaZx7/9AJ+jJMpA2f5J6Z28d1C3CZR5J
         JIVqupOJgrxa3zTJS3WpQUFSRLjnZvMlyBP0uwi/nc9dovrrSM4Sde+cI5qbMd6uMiap
         u4WVtc/PDFTnl8EHZJink4/z3ruIEPPvpihkWNNRSqm1OlS1+GZlxiiExTDey6Olg+Ev
         JgPQuNT47DiHbBVgVKR80/b7xuH1XtOgsT+kjtp7IKfgfIx9z1WkrHiRNrfyJZBYq3da
         zWyAIpfWTDpNEywuiXqBDk1lb7h+Lv/tdASqxOaoAz6xCq5GLPZTFQcOggdJHc9n4NtO
         +NVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786513248; x=1787118048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m/seKxW02ByOnB0+QTpdy9uY3bXNt5eyT11VbzK816s=;
        b=Jz2Z6J8Ixs6NimPEQy9sKep53S92MFJXqWjUKFdiDavJJpSsajB5bBDC8QZB2BJsye
         Q8b65I8sj3IhW1//ZVVdzUdaezZocwe/Zqj5kQN8eFf3OWduWcG+uHEopk4hozH7GIAB
         pHixYe855QgeLpyKb2Thcpg4Rux3xRDGBRwlLnAnN8dXHpgQhxZOutUj5MjelSWx7EsB
         Eij5P5AIYCzzjjR0GPPy0XJBBTZpJGMk1JRWdcESnQD89xKU13MPM3ZLTHzWRCG3poFY
         4aPseSBSAosRNuamCnpzXwzEYqzeKMG/8NfavsPLXHs8WLGoybNodB6sGTYm2vEXXSZN
         jm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786513248; x=1787118048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/seKxW02ByOnB0+QTpdy9uY3bXNt5eyT11VbzK816s=;
        b=POPROJsDNjuXTWGGQ+4eVMjSicPw3z0FX7dC0tYf6bCutitocAbrJV1jswWqd2W83p
         w2hsKA+aeNTH9nHSFWwP7FyJkpVJWHK0cXylGtfJYrRBh9DHxIC8bgOSE35u0HAb0dLs
         C7Df4iwFSOslKBhXmOT+aea00xASvjr5dV/j4YEAquI4P0D/vg2n1U7Cs55i/e7iirxF
         AQfaGosM+mT6lJ7wFq4yuBlZU1yySoDTSz5wzAAMFKNW1GqYYeS0KQYW52Top2yEP7jb
         1rP5JaA1AmcUN8uOUEbt6wPIgLSP8QnH6nR3b4XNe22jO01hq6YF0wHodWS9xEUegWDk
         MpGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZhNrc8X4C/qf9V9I6grDVYIfFIQ5WWqNZ8QLBAIy1WtgVb96Q3S88pjpZdYHCnS0FtnU7yO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfRcVZA4uNekyr1qqsbv2LEEE6D9Ccp/u6BWnJpP9IA4ceFwO
	sr4cNc/H/pYknETtg3YuJUxZiNKIuDcqkyXAT9q61JRxaRLz1wKy8C199zzXpKocDgp5lx0WIDn
	I81+VasERAaoFLvYQLzF2rlF8mbCDNAY=
X-Gm-Gg: AR+sD10lbP9iPLxCS1xDma7LzTC3FkvlEA7/01Uqge/DxFfR7alWbGlCtxwkH/OZ1fI
	Nbpra3XjJZltJvyeCDP8TtbzNvsSZ0Y28tdR1wjZnwCy4YlYkvwZxd79AkKeCo08thFVIIHX8ul
	wV+OA2PNsDQZxTrUoY6hmazZTE343YcBzvGJ9+oJt0JqpFQ/9KkHXJSWnDGympWMJiNSkKclATU
	tsCRj66rJiDXG1/CCvrQeTzZ+dAEHafrxO+yWD8jgCUAiNpHsq+7K0gcHoxW3g7jr1MrpyxqTq9
	fVki5LF9S9PEmUfViYgp/zJ/rraIUwU4XdJlg5LAtOC2xSCZ0yJOoNhecM+uRAvPEIQwXuIe3Tb
	yZXKh1MxVQmFgbe6g8hj6s962PV9fZIgOuww9ws2bLuAfKgxYMiSipSjpBHEZo0n+JeqqfJxYTb
	SxIyFILfMU
X-Received: by 2002:a05:690e:12c8:b0:667:e8a3:eb87 with SMTP id
 956f58d0204a3-66b34144aecmr1111382d50.17.1786513248612; Tue, 11 Aug 2026
 22:40:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 22:40:47 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 22:40:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2026081214-litigator-nutty-83fb@gregkh>
References: <CA+Z0x2JOUKR6cH41JyFHBmG5L_XoVEa02vrc91-L42RX5oa5OA@mail.gmail.com>
 <2026081214-litigator-nutty-83fb@gregkh>
From: Jason Colapietro <jasoncola1@gmail.com>
Date: Tue, 11 Aug 2026 22:40:47 -0700
X-Gm-Features: AUfX_mz81W58lX-6xZZVf61oqNpZmlfCoL0gtL6qlB1v4ZYFnlzhyz2aLE4gVbA
Message-ID: <CA+Z0x2JqGxXmf7y_bQpTP-OgqwPbDAgzvCVpiXxPrGx3LxsKdQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usbip: make remote list honor parsable output
To: Greg KH <greg@kroah.com>
Cc: Shuah Khan <shuah@kernel.org>, Valentina Manea <valentina.manea.m@gmail.com>, 
	skhan@linuxfoundation.org, Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for catching that, Greg. Sorry about the noise =E2=80=94 Gmail mangl=
ed
the patch. I'll resend the series as plain text using git send-email.

Jason
