Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198346;
	b=U8B2140evbPdeOCKDucY3M6tQIs2oRimrXnFe3RDR3GsszEqY6tyE9lT+6HlPKWXQjqv
	 XRNKWpYXybJ+bCiuIK9KZgn3Yuxc07jqt8U5eXiYa83HbULVj2h+Ic5jDgh+HgKayVcEW
	 CPijnubvCXb2Hl3xG19ZYvua8W8VX5JjkKbn6q5AyM3bykPik6p5ORt/RcCTWXpHZN+JH
	 5PvPncj/D+vhuSXLuHwO1fbneSSFLk7zJV8954wbp4UZ9ANzXYCCBaGlsFAwf+yotKbOP
	 qaddzNlqlcPFU1XBgDXuH5vrc5KDZAwXw/5Fk1KXjeE/ltfZ6cRMTmVmfHoXkQ1pfow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198346;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=KcwRryR3neRBeXsDs5tPByJSDLgkVU6x8pfTYeBco80=;
	b=1wXwuO5w4YblRc9/J1SJw2E6+o66T/badt6fTbeHYY6OPloWd5IHIHSncQNYVYvufnfE
	 sRKjyqOyq7RW9SeWf2IQPqqwwTUSW+55TMHIA0SCTQM6FzddhWDYVswuGUC3GQoHp8/Qb
	 RuNDJaA/GPDQAGZnuuHZJfGArJqGimZey9n4nT5KoRXQWmXGlDdAwckHTmlmP6oMIUdZi
	 T4sDJBAwJGWY65b5ZrWkQA8bLiFqW/ksvQCneXycBIu6N9yV/sfWp4MggSr063JGXL9Js
	 ycHSZoJItsMyAIMgbDdg9s98v7FPoga7wzv4dRbcpKG9pb3hblUR4sHH38UF1/BkL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtKAbNqU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD89606C6E8;
	Fri, 20 Nov 2026 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtKAbNqU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF381F000E0;
	Fri, 20 Nov 2026 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198346;
	bh=KcwRryR3neRBeXsDs5tPByJSDLgkVU6x8pfTYeBco80=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=FtKAbNqUGHwj0s1LLutnHR5QtqThcZtCW9uc/lzJXEl+cEIl9vX7qS9EBFydcX94V
	 H61X2xksTE9pcOjdBx4KfezuokBEXX2kjj2Gn2o3bsc+MuVGj8UJR6MlRl8ocs5CBR
	 qcCsv3zxo8wUPx4rQPlk8kAH1vIigIXGmpXVyPrZG6VjDafFnskm+fB+gu96Gju8ab
	 LbnGsSHGgjNaUgUUfOM2s2BSq5FucRyATM56Ux/K8c86TjYWtuMvzlztJ6WD2LBmzV
	 G+29orJHXGwa1Oh0/NRO+y7igdECELhFQy+zEoosGka1WI2doqvEQT64X+a35DqpQo
	 gfUoURvi5T5ig==
Date: Fri, 20 Nov 2026 19:12:23 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
In-Reply-To: <awCMOvYf64DZfuWF@google.com>
Message-ID: <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com> <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com> <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet> <awCMOvYf64DZfuWF@google.com>
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

On Fri, 20 Nov 2026, Dmitry Torokhov wrote:

> Ah, yes, I un-exported it in my hidraw cleanup patch series that you
> just applied.

Hmm, but that cleanup is sitting in hid.git#for-7.5/hidraw, while this 
build breakage occured in for-7.4/upstream-fixes, which is based on Linus' 
tree and doesn't include that hidraw cleanup ...

> Hoisted by my own petard ;)

:))

Thanks,

-- 
Jiri Kosina
SUSE Labs

