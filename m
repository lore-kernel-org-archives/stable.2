Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793976570;
	b=QZyHEhbn7ABCrr5mEWpEWX4K/foIdlaAJsZAi+xugoFPydjV9nYMupJrnwZq/SDyyhbS
	 jjrsel3X8ZnKSQelUDfGt8rdGx96hdDrod9a1VleNkDn+zGmokfgaG2xmW3YiBf0J7OhF
	 2rvB0QeoCa1BVdYQgQW+tXUaX3zneuxlRsx/P6k1R3eP4JUrv6nRkrBE1B9yjNnitTHBP
	 tggdQc9xFfhIUo8vrIbum1uEfB7wPhYxgv7JpIC72AEgj7YfSyEo7nX6lNib9n0dSZXHA
	 sNANfqukJQm0kptXZDR6ePaHXhf2IUH7USmjI2aBdQ/WEEAUG7AyLKSow8FLMGp2HRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+Uq3ccaWd7fkRO2giwzEhKhp4Q2d9Aamt7PEbt3q74Q=;
	b=EN/H90snvqXqleuyi9qnluttG1qPtkuuo7+2YUAZ67Sov8SBSGbZYRiMpsNFF/EF+zFX
	 svuqz6XnadqcFblN8KWYdu61PmYf26gWF/fM192cN0xS9/3EMWAfh94TM2ISArCsoTAIW
	 Mr9ZqOir0MPdrnGZjkALhuIwU7kPi79bGIvgf44zh2fjx9OFgm2Yfa/D7nNxj2x60GbPX
	 4Lk/tMxtnBiJ+NZtIWhQCuPVV9NaB9ExxOANrBKJWCZ3UxcDqdftYIym5e6HKq1OQt7Eo
	 n1W6uuTIMec2Dp38suZ0m5RvyyUfhNBliH+yRlShp76Pwe0lClR7UGTwcE+MERevP8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e1fvAOd2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE18606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE18606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e1fvAOd2
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a6ee9c59aso107931eec.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 06:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793976569; cv=none;
        d=google.com; s=arc-20260327;
        b=TClzRegp1BhfWa1V5W5hr8q0E6TRtcxshEsuVHYZNAy3hyhQsN9a6f/xsHN8jUmQzH
         9hj8yWGSiI1PlCWUuE6L7IdUkKCu6Ueu2uYjgehqHI7CiBox/AQRxzt6XOV4pxyFwrr9
         0meE99i4pZTZtCxJFwScrEqQed8032Jznhyrb/cg+jak17fzQEcPCjPMbFHKLI0FIL2B
         wComX6n2f3MBl69gWyLd+Lv51MWmcGykr3UcMKqX6GsCaXUBSJIlJmVygcyYWdZmgjIv
         K7XxK4vIPULcRrvV4ynoU0u140GzHN67AQzwQ3W3DuFw+gMi9f97OY+WnNLXQiSkYz5M
         +SiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Uq3ccaWd7fkRO2giwzEhKhp4Q2d9Aamt7PEbt3q74Q=;
        fh=uNE+3XNxJMz8cjqo/XW6gvuJBdTinDWrGyM0RSUviGg=;
        b=aaOerU4MOV+YwBVJDsO+NxCY/B/uLMssbX+Rf8j3ghpQCEQ0h/jx0VvGBuMeARhJDg
         6a8Vqbj+5jaIN2oid76hHsSoA5LMNyILZdfwazOHl02vpPG3bs5UPGLeHIdvDUpMrYAq
         U9xgIKJ/x4CMkBc5C0vBl8h65vZ3dfeToOb5Iw04DHmZ0BoMLK2rBTQewHKa96QKhOyL
         gzsh0TciKpkDm+FNDOm7/HF+HAKGD8bMpCYbvLgdBsf8e/KuckSPYVnJBq4AAVYlJisK
         6hXtGgn9Z7RLh7bF6uo3vpm/XZsXe+o4juDtQ3Dp2MM1FHd2vNq+GwYNQccmgPxdU5oG
         yMXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976569; x=1794581369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Uq3ccaWd7fkRO2giwzEhKhp4Q2d9Aamt7PEbt3q74Q=;
        b=e1fvAOd2uD3CisHs88RpjqGC5sbtPt/N8Yw2bckZBqDqiKLM43dGykySp76Mlj3scP
         brRWGUqsp4eLGg2YJq8n4lAgpYyvxuuJsS/AXGdr1cpKrvH8VQ2SXk19oWFFs1l+CA+B
         Pfl5QhyWBWrF6cMWLeW5MrD9hXQAPAN8vAkrmAIX9xJLH9tUPGbYZLbzKgsOLTjGKVrG
         VldlWbSjoUtLSVa3Ssz75qT5MwV8QBpexLH7fbBpr5KbgNZJqCfUjrD/66cpgcR+bHEd
         cxyrfP/EAi3wpXGIlfI/mvz2YUlonZvb+IXJZXh3Imn+GhLFyTKD7VMOx+p+z7xsKG2S
         Z9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976569; x=1794581369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Uq3ccaWd7fkRO2giwzEhKhp4Q2d9Aamt7PEbt3q74Q=;
        b=q7e+J/pEPz+FiVUtIRxfHmOj/h6uESZNy9qosqpVEfI0uph2ZnAlXQn++oL7N5ZYrV
         1Jhw1UGq1IXtmXjc2LMipeuxj58vIq3U/M7OKNrj/sEoqqq9+57ispbnK323VRwtc9m6
         kz3kNRLTVtTiCnQt4aQpD5Gtr9zychMIF/L8nPzB5ro7/oXbeiBODQfQxbZWEA5HXD6a
         S4Uel1uJVbByd5TqNoptJc9greKASYrykK0WM0MK5X4Nm6OMT/VSM0W/KhZZjWhN2/Om
         uZ85PpK+ipasrtmRlhgIXlgwz90a8glLSItxqEFjiw+pBMPKO7MWQp8apmSkqdE3mBAW
         RzZg==
X-Forwarded-Encrypted: i=1; AL+hErEVLb/PeumNQZObuTWz5UaArf1F4XKvkur+98Hd14SO1moUoljMI2ylNQTKTQTh2I3lf+MgSQw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YNWpW4eb2hBncpgKDHII75M83T0qw7/Gij4riBJ0apgVHEzEi
	DzCPSukBmyTB4hnQtIky+ZhmxuNPBT6oyTMXXGTl64KOAThpLsBty6uw8pYhksKejVa96UAJkoc
	nWEsy25lNZlv587ht0zExxnoz9uNkYgx9n4uDdWE=
X-Gm-Gg: AYBFou3uLyMXfVUiq7G1lOYWwRKFAwAjcI84NonkcF6INhPYeNjbvSRpQW4s3VgxpOq
	FfNbqfBLZTR7E4yw02gUC4It5P/UKDc219R5AHACXcj/Acret/WuWRPEKEjoY1VaH+PSsJbhUbZ
	YuKw3Z6d3ACfI/UOLOmufIlolMUWU31WODvOZ8+cTZnO6YbxrLDMulwcg7oNHkwZ0NjanpP3iqS
	wYIZyNTBFAeCjCd9J9YcXzSb6dDVk1STonB4WTzz9ekqq0gqnQsBIwvSevRECdxNE7fmlvat2Cw
	4bS0nGQwgQ4YyURXQ0cow3liWuQKCUp+LzQdEa2vhLTGE09mj7KDraJsQdFFfra891PcNWzHeAD
	uVKtMVXo6TYW+fcJktXfuLD3GsZKM3aDPdtWk1gWnRx8+mugpHJz2X8GkxfHjxN+pjadnTXTR8N
	DeLxi7R9bVdDihO4RgbVnGoNatYSDbSwicMYOe7p7JvTC1pJblQO/y0uHXc9/JvFZ1gyHlqERqE
	puGbZjPTU5v9LcdoOI7yVWvWw6J89HuVMyi
X-Received: by 2002:a05:693c:2503:b0:36f:10ec:f692 with SMTP id
 5a478bee46e88-36f6fb7f196mr5010433eec.0.1793976568783; Fri, 06 Nov 2026
 06:49:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110412-idealism-matador-e917@gregkh>
In-Reply-To: <2026110412-idealism-matador-e917@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Nov 2026 15:49:14 +0100
X-Gm-Features: AclHuK-4J_Q1FcHHB3pLwxMHuOqtR4d_h85Y77rwXjqSJF5ocbrO_IU-w1ktrbg
Message-ID: <CANiq72nURMBn-HGMvvJ44_ttydVQbdX9KYDtQ8cSJBVbW4b-XQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: dma: declare cfi_encoding for
 dma_data_direction" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: samitolvanen@google.com, aliceryhl@google.com, dakr@kernel.org, 
	gary@garyguo.net, ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:14=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This is at (as a series):

  https://lore.kernel.org/stable/20261106144721.29080-2-ojeda@kernel.org/

Cheers,
Miguel
