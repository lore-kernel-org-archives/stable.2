Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2F366564
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352633; cv=pass; b=CH0ZOIi/ySZNhmGTL+gnurytvhiVnEQrcwAhpP0EbgcgslsTKOJ21JjwaFik4w5wGfsvZSW1/tet+QRAsCdAZCNjwsAvB5XJrWWWPmfmVE6mfOgAwVVARCF7G+4YHglLskOnseA+IYsv62r9TRQj1VG731h64Ia432XaxOV1tQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352633; c=relaxed/simple;
	bh=St5k3xj4AeRhAT3qhfUkT73XJDbiQlQOZPv5JEO7Dv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBx7TDt6Y5Jec8C/EuCPKHbu0KEvDHtAkXeF/AjXq9RlwS/LIdiAcVHB2rQa352w4pTwEHoFKyP2N2kNE1aN9+R01nnqR5bZBzSoVrTHQig8G3pmrEOUe1on03ms9E/mgy38rfTejUptS5eAknpImCCZrE308HfIx3pSTQA3g5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLSNAWpG; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLSNAWpG"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15b509c323so1119211966b.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 22:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784352630; cv=none;
        d=google.com; s=arc-20260327;
        b=X3eIjYXKK04HeFiSVkVeIE1GMQU9CjQ87x/5l/I+LUamq3XboZeaGkhzeE1gTdvisw
         HqYM2r4yFu9HvmcJxjiwhKFQ6qXKQm3VwRUNa3lxTB848dfTXB0URTiIQikb5a8UkK9l
         Lr7bdhOpa7tqC02gCtZsfeWQDxwcDibZdJCx0gOIO4QvDgPCOZC/NonTvlHPDTrJWhLt
         yZeukXwWURJPuv02PkHStO5/yjXTB9HOIFtxq9CKO7KxS6aA9cfxZI8K+Tkr4iGNUW+9
         fbthjyTNeNFTAzvbgVYViljjO7og4iazOD+XB2RvaYd00D9OgilzCceMxItZbDyLwoQh
         gt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=St5k3xj4AeRhAT3qhfUkT73XJDbiQlQOZPv5JEO7Dv0=;
        fh=j+mfeEywSerLjn6MuTNw9AVyKmZe3xFZeLTkaKWQArA=;
        b=Kfdj7CYn+2ax9vnWfcTKkJ72H+4uTuP4goimfcKHFfQkSR4Ow/xZwLu2T88waKX5mP
         B8jhQTrf6UvFndWJAR73JDdgOCRekLpyChkVhudMgrNY3B6UUHenGlz6D4MkqAwTvyQ6
         uRIrfjdM/vZirtd6xKhqtHAHISFSd8NDbEmUMTEfiGCRv1l2XxfRXLwUJLcN7SAtP5Oq
         x/mxOl+DSuRCMHhSX6Ojn1R55+5mbeqncUhe4mKdhOANP/AcjkslyYYqKX3CnsKLP+PZ
         rxwYsD79G7pXJSQI1ftIx7fkL20jW7eKjiBkvPFJ0TsbAuVNOCRhtnaj7qgaKdujhh2y
         1fxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784352630; x=1784957430; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=St5k3xj4AeRhAT3qhfUkT73XJDbiQlQOZPv5JEO7Dv0=;
        b=dLSNAWpGn+AYA3Ja8ZBDg6U+/i+xfqMpH34m6m9kjklwRkNUmUsWx7D2/3kytFqpzw
         zqPPKFBg5mIHGSsXuoJEOLtZyOoz6XGBVzpy+w+GzXF7z0DzLgmLlEZFpAowngvaT1Zz
         OYmnhQx59SbVcbXiMBdUrGUE5fQQoMbf7/QxWKN9ToMrhf6jyJ5PAodODi6bMUtleX67
         gZXl2DIJNcd6TvPEpiUJdnXnrD8HdlwOA8t0cTkYCUYxrJGIizZW3v50+qKGFAUaz7cL
         60csjiweZU7cT+VPlBySAHD8zok8+kUydSXTTAShOkK0sY2QWt8zjjaJXsAasFOUxgxg
         nr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784352630; x=1784957430;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=St5k3xj4AeRhAT3qhfUkT73XJDbiQlQOZPv5JEO7Dv0=;
        b=icgECFEhoc046RKpfvUHlwhm+xroRTixsf3VMAc012UyUOAt1o2EKlg+9WOCFaUA+9
         d6HFkUL3a1RMWtyDhHkTg0btktC996kJ0nWsVQdL3tCgXjdsNHU3sFMIc4z0qWRlclJY
         P8a2cpsEWBlLlFsT1iqo0elvzOl+AJ8FpsgYrPezEdGKN3h3plZku9leS8bd9rvdcOWs
         L3yGnbgyt7cc2FXmMJ5LBVGlJfParzUPnnZYXeHRb+mknPnm5RgdrboccQBXLdEs1cCu
         gS6zukrq678INNJPDdaOYIK4Cwosp73wOCpxKanr/MSYhXd/qLkBf8IlJ1MQf4LDlw8W
         H3Mg==
X-Forwarded-Encrypted: i=1; AHgh+Rq021Pzz61yO9JvsWofpDBRKmnz9KE8gNNq2L81KboZxabAJQKjykJDfod+5ITPyDjxQnl4WNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4e57Ed/RAY/BE5cAEWkhr9KDl/MnxjvoRECi9N4kL7Qy1YLoH
	2Kr7yc/G6CheemAcnwNU+uOVHvWNF+LsD1lyLMkYgEMSu9T5rCCR5HtD3Z32qCVLMt5rOMf4Fhj
	hHDLFFUxDkkr1j7LwNbzSseaqfp9ZAY0=
X-Gm-Gg: AfdE7cnXWk234qFvneRhwOTLjpOvSzpDOiFFb2wqbbp8lNETJwIaYa0vEjBJ9noO77O
	K6EOklNQp7x/mKRwtOyonWH/60/AwkckShHD09LVXwaKzsQyjEw+SqCClHmNqQqnH6zEC+20AuL
	rB3NZGe5eI8gOesXuOGt9YBFJyir+2MCGJdFtH+/LQGCsKrMS873QzyBUsyzU/YEGLzzXkBXaJo
	kP/khPti7lt2/mq0seO5Wxisq8QNdEgodYm3Xio80YgkhxoM9H2Ytiu+y26HjMZy3zbQxlzdmS8
	E1wKeA4voe/cDc7/Qk0CxZXcLxgMwqDPHbuWvLvbbd8g5X4=
X-Received: by 2002:a17:907:e1d3:10b0:c12:34ed:da14 with SMTP id
 a640c23a62f3a-c16b47ea252mr147632766b.64.1784352630205; Fri, 17 Jul 2026
 22:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
In-Reply-To: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Sat, 18 Jul 2026 11:00:19 +0530
X-Gm-Features: AUfX_mxhIJFm-FhL7GTanL1EAGlmqlbs9olf-RM3hy7jEr95fa0uEkWsyyRhdQw
Message-ID: <CAFgddhJpqOO+pBrVs6U=mMOfXrO1DPTZ6XAbwPQubjYz4ZB35A@mail.gmail.com>
Subject: Re: [PATCH 0/2] usbcore: Add quirk for 255-byte initial config read
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stern@rowland.harvard.edu, michal.pecio@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry, forgot to mark this as v3. This should be [PATCH v3 0/2].

Changes from v2:
- put strings in a single line
- copy bytes from desc to bigbuffer instead of pointer aliasing.
- change tabs to spaces in documentation
- reworded some comments
- drop USB_CONFIG_WINDOWS_REQ_SIZE macro
- revert USB_DELAY_INIT to original behavior. no delay before 1st request.
- split announce_device() so we can report device ids early before
vendor strings

Thanks,
Nikhil Solanke
