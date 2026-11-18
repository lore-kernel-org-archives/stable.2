Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020725;
	b=MWYHyVURyzTh7vn7eL6oatW5o57tQEodKLrFSz50e5zhnDJWsqRxpceZmC4X7Na7MhtL
	 e8xkCLxQTWGN16uq5xekrh38MYJZFPeDZ6PZHV2rJCnTOmTLKHRLVNHN6ACCOSMzJA2l+
	 otx+cFZ4RI/ziyOL7NPpw63AP8kTCO+ToIk0rKZl8aa8ek5OlTUo5H2pnai2HgHuglrPv
	 c/BsdktXM6DkqJtyYyQZOkgV2GB5mDGXGaXPj8rx7jcEy899zoJaSruU7hmC0JFtU4Mqk
	 wTjfTng2ihHqsORGZ2E4/6ru8WE4RTkZTVJVtfcPD6nkcSsKAKTAhWoS+mYpa+3Q2aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lp+PumDUYSckbLI7kydkOXPsLnRNnUF1SFah0ZOKP64=;
	b=cOj4Pih4gfC2NKRRaW2ewZkQeXBLoNtecEhTmsU3Wm/3YOX3zGmR2kkTLmoiKu+4rfD+
	 lyblrHRme+jjrj8dQCDwFK5bufnqQ3TZ3+YGEDZBN30ISreVsyZB+m9n+v8x2jcRUHDIw
	 9TllfyQDQJrJsWw7FwYQvlk8pgt0pNCYZ9kQ58x4zAGQDxUXg565KuuDbJbjJuewU6UF7
	 5rE8NNIkoIDiWtMBTyDiVNMhbBwOuBysd4Lwh/JO//KDbtpmc+rDaJwlZcC2NHTXfDcvs
	 zFeDOXhzVeeNeueB4Mgz6HibG6jVq74jyYLS+RSYlFVRcgUqOxSfG6fqcLByS/f9QNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ONoBF3aj;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633660A381E
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8633660A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ONoBF3aj
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c40e30c26a4so3731666b.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795020724; x=1795625524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lp+PumDUYSckbLI7kydkOXPsLnRNnUF1SFah0ZOKP64=;
        b=ONoBF3aj05UMAoHktbPtPdrDWFZqTLusibCB7TzP/QP3cs4jxg8XZ6i8mQYeszW5x3
         3PRnMm7t+Gft+LpwzTYgyx6DKfVLTdiuR5SEJbFCLgeS7grQMIbD5cvCdnfEgVgXCbOn
         eeD1X9lDIgAe+d3zFl3oPgB9+ihlyMOXSWtHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020724; x=1795625524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lp+PumDUYSckbLI7kydkOXPsLnRNnUF1SFah0ZOKP64=;
        b=i+fhoBkiacPoIxY+LXegJEoUPmxWoLlngUM1nAnxNoT9m/JsxpxLUrIGOxPZQaMqsV
         jlYrfK0CugTtlH1xfnpeUEdbkFstzkLPmX01stC8nhpV5VrffiMdOFL1ZtJw0dmNQ3AG
         8QoDGMoQ9Vj68XNNK6YK/Sh2JRXghdLP0wfo+MHRHW8woxgfkCQnQXYLPP+RCdZ7LQW0
         5PEjFaMFxvnO2nG5BFbgJXrpvSEQdyDuPklQEONF6/HmF+9E5YxOhjw5Ws76LDecHLRH
         3IjM24RClfFbVyGih+CLTlrszZ7IMDCIG5Q0yH/0r4/3WddnSouWYRpYBeBeORK+fhXh
         wl7w==
X-Forwarded-Encrypted: i=1; AL+hErFXeV0fBxqWRYVHL8V7nfYNs8THX7a3vztiLQa2vYU9W4AYFXNTI1g58/yWi7CAepEwWGV+IpE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9/zVWWXyc9CXEw3nw9rfNF/Uovh+ZuFrfeqRqNsKEV5VEm9Ol
	ZsdkPzu9E5aO3uRyzHsS96cybpCYG7ksduurTvCFdtBJWzXU5gXz06BUgzHQSN2hS+IsD25EHAj
	FJvIVwJIw
X-Gm-Gg: AYBFou3+B9EGd6V9aBnk73kLXFoaY+ZutgnuLXVT5M3F9tXC0ykE7fAVn4Hrbf+R6cl
	5yaP5KmODFtJJt4RZIseecCdksw1jOkrn1NZwCuBeCCLIObP8Lo5uNwEvFs7jlS02UjHKNl+H/t
	XLnegKCjxm9cormlqPaAWQanZh1/CTckiRXVUYqMaXbl/gbmW7C8GZjy+W3LfRVI2JRyOSPq8Yk
	Dsq8Dfk2sujZmFyNW7np7mvCuGhHw6ae11mdug9RtFfZ+236Da/J1O3vhOba3cEVJaisXWCar+E
	Zn5rnpv1nyFvIioO1El25tbhPZju6TKmrYJ5hd28Yk22O0jA1/PYzsha2w5PGonK5mmFVnLhZ3D
	mY15rrLWWlKEt70YWPgYwv5RrKux1C8StYGsOH/RrXetdva0tvyqoUoAjrUqo1HPAfot65kLy+L
	AC+dCvyjFdjujioB12ovZFkRZAGPfFbwFZ8sO79prQ0GNyVr8SzLwW5niw+BysdAGMzfxImKkFy
	LAdGwyBoSSgojSjYwfrsQUDpR72YHQME61wynMSXJSggb7X3T+PbVR6xElDMokmtzYxyPAN6H98
	MSdycaFmd2W9byspvpPvvolMnWMO+noMQLGkav3GKGfsux7e1lIXmsjcQwt6jKYRo2Zi
X-Received: by 2002:a17:907:9252:b0:c51:45a:1a5a with SMTP id a640c23a62f3a-c5125c836eamr10263566b.0.1795020723654;
        Wed, 18 Nov 2026 08:52:03 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51231ba848sm25308366b.1.2026.11.18.08.52.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 08:52:03 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490f38e9688so10093f8f.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:52:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFQvcI6pDqtZu5zcGkXg1Iu5MGhsb6AdAFQdPYSU/20fIMUKD7R7675LoiNLrgNuhS/OeUWZvI=@vger.kernel.org
X-Received: by 2002:a05:6000:4212:b0:498:364d:7509 with SMTP id
 ffacd0b85a97d-4a8ee39ac6fmr44021f8f.24.1795020720874; Wed, 18 Nov 2026
 08:52:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118072853.1578323-1-a.kazinsky@ideco.ru>
In-Reply-To: <20261118072853.1578323-1-a.kazinsky@ideco.ru>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 18 Nov 2026 08:51:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W5MJMfjYvaW+5y+SwSXiNSGoMyJGWKVyGyQJU33+1QRg@mail.gmail.com>
X-Gm-Features: Aa3M54rw4QWacAhRxyIy-HlXKopfZ8-xwOmR9x3eFc-lDVUcxQsDNdYLgHWCWl0
Message-ID: <CAD=FV=W5MJMfjYvaW+5y+SwSXiNSGoMyJGWKVyGyQJU33+1QRg@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Reject non-positive BYTESPERWORD before division
To: Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Daniel Thompson <danielt@kernel.org>, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tim Bird <tim.bird@sony.com>, 
	Martin Hicks <mort@sgi.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 17, 2026 at 11:29=E2=80=AFPM Alex Kazinsky <a.kazinsky@ideco.ru=
> wrote:
>
> kdb_md() uses BYTESPERWORD as a divisor when calculating the initial
> repeat count, before validating the word width. A zero width causes a
> division by zero. kdbgetintenv() also casts an unsigned long to int,
> so the resulting width can be negative. If the width is -1 and the
> scaled count is INT_MIN, the quotient overflows and raises a divide
> error on x86.
>
> Return KDB_BADWIDTH for non-positive widths before calculating the
> repeat count.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
>
> Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
> ---
> v1: https://lore.kernel.org/all/20261113111152.4190309-1-a.kazinsky@ideco=
.ru/
>
> Changes in v2:
> - Reject negative BYTESPERWORD values as well as zero.
> - Explain the signed division overflow in the commit message.
>
>  kernel/debug/kdb/kdb_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
