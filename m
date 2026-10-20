Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516370;
	b=CnNr6U1inKLjhxl8BIohK5HbMLZ4Wl5kpnhgojye8ioQPYWTN+AzoXODIZGeF2I2MNi7
	 JqQno6sxi+OfPANlSctL0b4QLM+jIEfvBd+afN3edAB8nDKe2d3tAnqg++7W81OK5kB/a
	 0f3JQ1LCyQSOa4EGF71v+IDkVJzo2nbjTbp22/Op7LDSwnHz1jghsybLhNeFEqE716YTB
	 Q4ICfY0VhMOJchAsvGw24/ufesM1lEMk/j+EP22NGyuhNUmu5Q6/O8TViBbfU0z82+0VQ
	 EFft+Kw8SO0O8iDPmquNw/MgriUaPFcRf0sjLWpffw+nu5yDtm3aPrK0DzUc/zz/JQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=fhqQPB4XMnfyiI2uq0u1TLnRiFnbRNlZrECWOidHles=;
	b=NkWHXmKQeGfx59xhWJayYAdiHMOPSlAkfwCJnz0XEQzHIwe+PcuFRUiOgo6WoyuGo51H
	 IMmZcOApJChCd6zfPr20kLYlJLBsjnJwdBYi4w1UFt0OnmP45A2pM//MJUeVTSJ9KZSiv
	 RyhCU5yDAtMuQozYENXdDXpXQA7tgq9tB4dSilbuZ++4oy7fVVcyeUezD/zt5j6NVnamW
	 1OGcKPZYHCs+PvcD/jfL1JwcztpbqSJ5ey3qBgAXYtsf77J003ciq1/MoQy6OFZ2hSDoM
	 JjnxoHVWrkJbZkXgksBsCDNP3pv0jmIbSbQirFnJsqbYI6r4drP6zDXvTSC1/pIdxNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=CYVeJVEJ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D4C60A2612
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45D4C60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=CYVeJVEJ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso8179745eec.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792516368; x=1793121168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhqQPB4XMnfyiI2uq0u1TLnRiFnbRNlZrECWOidHles=;
        b=CYVeJVEJ1KM+wdsacNjapsabYjwSWLhrAOboaZh1EUNsCdZm4ANjhiP8hRfRgf5wTF
         N+CFAOmyiu2cF1qIfxLLwrZ30eyjlyVhX54fAoyZe8ss+yD2y40evJEYW/u6gV9bLndQ
         eGVDc6dnrRDjlgTdywWaMn9lqkzQ3lg8ILHErGTFLTaD30EpbJfjX0IZXj8YM/q98LXA
         HlQP5EN7wyiIwWgJqUAhykBSm+ZfsjLsuLTrQwi35q4duwu1vT0zO7aRbHQGXEJA2ect
         mSRjIKmRetP6lOtY20H9QtB/5Ip2Le7xOFY/ca48RWTLr+6YQL5jQd8BlJ3kbyw9tOUE
         Tleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516368; x=1793121168;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhqQPB4XMnfyiI2uq0u1TLnRiFnbRNlZrECWOidHles=;
        b=QEW1Rtkw5NVa79PXgG/lIoviPyHoXz2ZAvwBQPcrtb511zVR7mThQctVXAEp6eMLac
         42nut1dQCGsdrPkqhlwBmF5EH4u5+cjK6A+HE0omP4pKbW2WBKOevPGXGCvl3t70ZJS3
         ++1zx+CJr/h87+0ZZYUlrOCMve7MuJez6YHAyIAzPtnicPXgwaSishu0+k4NBa0uNXpk
         SR1CuKjw3w5krjry9BpRNnV6jTn7EZOiGyVnCp6hNhutEGR3O3T0FM5xrojnhhH3ltHb
         8KKsMemDhhus7lE+ll0JqkZzrTbAxVUSGP9sqfYA2VbahP9OGRooOG1oTNjm3yxewuTw
         jNWg==
X-Forwarded-Encrypted: i=1; AKwUvBwSeikj7rG6p9zblWeJs2b8SDAczHYrkqfb3It7Yb66ETC3lf6D0G52Ub9pt91idrPx7ZoB5EU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLppbootfL5h9E3kB5VbRHxYFARveHmnLatbNHMKQ8Z5Gk3kV0G
	zSjPJN8a3iel2LWL2rWItGChVcHwj/2V1TO7VlGXaIiTFWUb3xJjIOMYq0p+Vmfj9Yk=
X-Gm-Gg: AYBFou36lREzheD6wtCP4cw944S5/4LWodjHlnn0cGJWQUhtqGUrZ5k4JJlcGXpBMly
	alXn1NAcRD+fuy2zyWEa077u9sAqjExcJOnCR8qC8tnPtMoeKoWetheqcAW4yrrEGdQRhWRlAe4
	swRXT7oNYJywAhsuA1Wv23tQV50it0eYOZlZmkWmKvq5/Zy6fNtRNLv+73v1sSzpJ0pP0hl+oVn
	uoiKOqjG8miSrutRFnzoKrOvLGgt3sisjs+vuyoum11x6edlfQrXG/nTkSRB5O4Yy4wJIzEz22H
	996yK9/P4WIxt+s4OgT34mTAESPWiMtzYk/jXldjm1hqIPUCSMEKObcWuMGL/IVNveAzUN5/VBu
	39pTXOKb8hBrD6SC3SC6kebfxCg+/g8wgjVkI8VSv1w1PXYYznsccQfNXZiRGseqgztDQghf6Pz
	3x5CzKhmv/WC2+bgo8T0/nnq1u8H3eDdnF9tGkp7Bfnp/nn9xbismfEu5E+X3gbqkwDFtJQbRl4
	nB4foCfjjEE1nNQR22/uDvKL1csXopkO2gzVwHcb2eysggMigvW+KnhTP1UmArOfgmYmsU3hjY=
X-Received: by 2002:a05:7301:430c:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-361a1668b25mr15610910eec.9.1792516368276;
        Tue, 20 Oct 2026 10:12:48 -0700 (PDT)
Received: from xps16.local ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ec6c3sm30711eec.7.2026.10.20.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:12:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: viro@zeniv.linux.org.uk, tz2294@columbia.edu, stable@vger.kernel.org, 
 l1za0.sec@gmail.com, kbusch@kernel.org, hch@lst.de, hare@kernel.org, 
 4ncienth@gmail.com, linux-block@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20261020170250.014BD1F000C9@smtp.kernel.org>
References: <20261020170250.014BD1F000C9@smtp.kernel.org>
Subject: Re: [patch 1/1] block: restore the iterator when rejecting a
 misaligned bio
Message-Id: <179251636729.3425887.10424065373314430369.b4-ty@b4>
Date: Tue, 20 Oct 2026 11:12:47 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 20 Oct 2026 10:02:19 -0700, Andrew Morton wrote:
> bio_iov_iter_get_pages() can extract some iovecs before encountering a
> misaligned one.  It releases the pages and rejects the entire bio, but
> leaves the supplied iterator advanced.
> 
> An iomap direct-I/O caller may subsequently reexpand the iterator's
> byte count and fall back to buffered I/O.  The reexpanded count then
> includes bytes before the iterator's current segment, potentially
> causing iterate_iovec() to read beyond the imported iovec array.
> 
> [...]

Applied, thanks!

[1/1] block: restore the iterator when rejecting a misaligned bio
      commit: 40d070cbb1906896d6fd65c39722d2411830ed9f

Best regards,
-- 
Jens Axboe



