Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D832D781B
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841880; cv=none; b=fRtLcPXN/Tu6y320iIz6bcFfdWVSr3Ot7DfNw7mWjPuBFG0KoPKJGT/WfJaFvaV6HZyHbU4cAFMS/436pVLUz06jT7kJ8JOA6jFZgBj1bujQjQ74Vy3yAWOm1hX+TsVqsirnZWfXVxQtYAJ8P+ssUYfAginXD4aTuJ/c6QSMeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841880; c=relaxed/simple;
	bh=v4JRsy1mMVczYpzTwrH27tSAPaBf/jRMAT3/DYT7xLo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=l1+SwEl7dKK3bIbtpNA4IU5Lzk7HQLbUoigGONv4ZFLBpcC/L9HnrsZHj55iFP92p2F6jyPz7xZ5Zy8FXUMIm2QIR80YsihIC+QiZGfaQGoMjTL/er2GhOZZS+pR6+wIoYLe4tHnDcpQn/wgpRkhppVSOqXgLPB3ChNQp1LgPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOI45xex; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOI45xex"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso1274637b3a.2
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789841878; x=1790446678; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4JRsy1mMVczYpzTwrH27tSAPaBf/jRMAT3/DYT7xLo=;
        b=NOI45xexohXzRKzSRY/O1lbVfzlQqgKMppiz6IO2OqdJtbXVLxM0fbr3hTiOmPUwza
         Z5igedgprnno84m6NdJgSrOMywp3DyybZNUWqQdpPbbS8PuBqAuaeUiK9JHvinfKeSUa
         RJT1oNXCaSJ0Q2ekPlShOe4DQQsLe0KAKLHoQE0dBeYhKi36N8y8mlF7Y/eq6pKU4jXG
         2xPcRjF3SmnFUrAPi386qdqLkD4G2dVSVWwhelX7QnEa2wKa11pF5zshvTJ+5mwQBcDS
         49fWubzu+wR9yE4qtD2dCEWj474IayQiJ4nb9hqpYmy5Bt8T3kSIqZPC5GqHIKMbxA2s
         grfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789841878; x=1790446678;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4JRsy1mMVczYpzTwrH27tSAPaBf/jRMAT3/DYT7xLo=;
        b=wvGzYvnHuAgA3Zl3aDopZgoJvcxLWUODFVeBxDwe+jK0FBQHomitxu+ymFK5zbbPMM
         na00u282LDdN8jusqG/vtz1pvseF+iTMMZ7crG/3XuXAjiDfAZJDdrtWeQwGlLcWY7l6
         54HT1Tf7mSNaFwJS/Z0uC9XBmsqpVMstsFLtUtG6B6b+gPflnT6U98FplkW2LBbDeF8/
         oY8IJ/3MuhPVrWo/5mEflt23l2PdVhC+p1ja2Nsm0PlwkC0yooyrsDEE4hlbiU4IkbIZ
         FW8sKjRUu6C6SZGbbCpDUXQVjWgFcCaJXNKzsJR04dbxKJxArIY9Q0d8NB7AjjAsz8vN
         9Cjg==
X-Forwarded-Encrypted: i=1; AKwUvBzBZd2IGFnFhsYoxzANXqOOmzsMYao2S45ePpfctIgIJrdnaEHlaUjos7qqNDMUYmUaXOfyxaI=@vger.kernel.org
X-Gm-Message-State: AFuF++lGIffZKCQInPL9DxmGeNYTMwCmBzKM3+LxD3I7mYXkEKz4jZlS
	27ZMNRspfbw6XevHwEsmOELGYvrf1latJlhEuwaKOohhRWB9HkVuScj7
X-Gm-Gg: AYBFou3WAhli858ka5MezSr86AyNFCzYgFIy2Vf51GZs4MXx+38Kjb37F19+1dF6AP8
	oGz9E/corwqNblYwq2IuNYjgYIeRreApsWXRDl+vKkAGW6fit0kYJzhkES/YMcCDkxhf/dBk4zF
	sBsnZW+7VHnbX4/ERYaGsAlmEL5YRaRLx8ZDhDFFe+qj9YfQIItpnQtOWSkZ+PFjxPV7AxMapws
	1UrrHZ2ovRws+wIYnl1/ZtvxQFzeXggD1R6jGTDSWbYpFowcYRLZuo68UAHeqQ85uq3gfmOOpe0
	1D8wQEBLKr2NaN3rRIdxWAzWV/SVgtBzK+zEIIxphAEDjCchLRbVASmWW2oHK73IXO21YqP3WgK
	6HIM/WTmobNaQiUYJmjAW/KCtWXwlABh2zxURDa8gQAWKQD9a3i+54+iSU0+SR1qUQM/4r7vP4f
	LTnRRZzLo+TQm0cRJEo8qBkfgjkQAqVHEv0K4v/M0qDcDYz4gGYOXOXFQ1C6UWmALKgjNZBJxkW
	T1oJ+4+zFV8JRtFfUPHpqV/j/G6LQTU31+rGIUkFU+Q46mFpM09lH9Px8Q01fjwtM9Pu7mtn5IB
	kaeSdH4CgQBJNw==
X-Received: by 2002:a05:6a20:918d:b0:3dd:a008:dc3a with SMTP id adf61e73a8af0-3dda008e123mr4789863637.40.1789841878321;
        Sat, 19 Sep 2026 11:17:58 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm1200788a12.6.2026.09.19.11.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:17:57 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 18:17:57 +0000
Message-Id: <DLJHZR9N1C0I.JZ6KOM8H5DPG@gmail.com>
Cc: "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <stable@vger.kernel.org>, "Vega"
 <vega@nebusec.ai>, "Ren Wei" <weir@nebusec.ai>, <xuyq21@lenovo.com>
Subject: Re: [PATCH bpf 1/1] bpf: crypto: check params size before reading
 reserved fields
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yuqi Xu" <xuyuqiabc@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
References: <cover.1789802413.git.xuyuqiabc@gmail.com> <4f3ab4b03e79017e215521743996555439bf0bb3.1789802413.git.xuyuqiabc@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 19, 2026 at 04:45 PM Yuqi Xu <xuyuqiabc@gmail.com> wrote:
> Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
> Cc: stable@vger.kernel.org

bpf_crypto_ctx_create() is only available to syscall progs, so it's
CAP_BPF, and with a short params__sz both outcomes are -EINVAL.
The two bytes don't go anywhere. Fixes tag is enough.
No need to cc stable.
