Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221605;
	b=FmJy8IgK/xXvySXQg767tMvieisXj1RkNwMx0ZZiQ3hPgEPElHlU2GL8+C1eYqWUB854
	 BAhVQobkahFjf3ocOGlsr5y6V2gCkBTUn1iILsr99KhrIqTbjGVNr2J1TqRsLr6xvRUXo
	 VgE1Swkila0sDi8GV1DstSgl8jv5Sj0UIEq+su1uyAMjc8Y0y4v1czVVUd+HuQQ0/MdW+
	 WQOarUfTBIzr73wfXscUt558U3F+8/1LY1rWQtDX5lec84GLdv3bsY8i3QEZgciflQGLa
	 dU8be+hEq1/j9Q0W6pKpa+On1slgRQXgMTUwgvWfzt2T+72gcbq+DYopdZKjz4xerbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dYdUZQkYdLc0vauWbIqi3zABPNcb2nwtA8yBjqhaLho=;
	b=tnZQgTWH81kMRN/AC7VZm/WkNuQrzDzsdux6BeCiyUquMZCi0v8jUA9y6C3C5V2WFUxR
	 5iXneStlCnaPZTZH8waTVFcboECQCKrJuf1kSgywh/pDxY12sbPFujnSqKcoyt+KS7Vyc
	 /gDn+wBasGTKb14w58sYc7IOjN5/Danjva3w2l1A5lQpDeCgOC6mm1nj3WvOfq4nqMotg
	 /gClKIjHhxoe6kAserOwTGyl+EuqIHTOZfOKB4b4cCUDy3nFaiUoxdpMwAcKI/RBdbqRX
	 3T7CDZWYFfFdkseNl0/m+XnI6TVyCDJ+yetz2+kL+ORbRvYaeebnG/BtHP+tG6dWPoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=RZKnL3TU;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87676606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87676606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=RZKnL3TU
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-48e9476e26aso533561fac.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793221602; x=1793826402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYdUZQkYdLc0vauWbIqi3zABPNcb2nwtA8yBjqhaLho=;
        b=RZKnL3TU91MknhH0PBI6QZVMUcwt1SUpPSrfgEKjkIikcI2UgLeVieNt6W/vKdD+ni
         ZlzEvAK8j+4uYNKqrUDlDHihQtPPOUoBEy0s0xfMsaOvZ8lBWNpEMl2uWLzPY6g38BiG
         HkEslqoetMhPitOO7lA3e/fOsmOLctT24KIE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221602; x=1793826402;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYdUZQkYdLc0vauWbIqi3zABPNcb2nwtA8yBjqhaLho=;
        b=OvZFcg0VyJtffpIsAe+EVlTeicMi6dFdMQ7d16yzu4Gk97HT/ngs413ucEdQ41FWm1
         mFkk66KO4zSTsYvCc6WrwQIJ3CS/nkYJvfhUogs1lADiqznPJ26TbF38tLb7s1JwiW9G
         mDPh1jN5TN6MLG2fRxOx5tJj1kPEkf5+aO75OBn4qb35fbbcqsYMAOEyiAUPsfA4+AG2
         WdFVfguCmwwW2826+FDO+FlC3voXm5/aFo0d7CB0V7VFuQBVV3XwWVNrkxqZ26hiT64L
         GIZi1qIXsvndzhBQC0rHy58YuQ020RjIsW+h+WtVyx6zNNe9MhUeKMACXQxXHm6o9JK5
         H4LA==
X-Gm-Message-State: AFq9FYKiuQFnpA6jRUcX1iMWSxvBZGq0I3HkjP9pvYxdrviW6QH0BNEt
	8YEPwq1YPPrZpdVFi33ui6c0DDcVSz85R9ADeq/h/K6ctnF7Z4OG7Ok0yWPnG20lDknCqcrIybH
	TECWhtFw=
X-Gm-Gg: AYBFou2u14e1ZnYU54w4b9k8utGgYRexOtK2tk/Oi4XIjCcGBg1E9+Hlk5b9ZcV0BY3
	ZmbsAtYZv2L82j+4rA+FCqB6sY6Q7vSUmQ6ZVrbq54GxuxIl6nF1+Ub6bqLGys0fD5rHjuFr2Dz
	PJe+IDDoI7Fgb9mCOGus8oHsREFqUAAnA4cXKEY4bI/w3mBgGsbQjqeiNjl+VuzphjV67c4jm1R
	mi+542jyfAhSuTaj2pr9QuZI8hRrDcX4KJ8oSQ/d2E/D1UoaP0H3PyRcJZS9Iu5CxcFaYN0HW15
	1EBrNvY2UTZyc3mt6qqFQ8OXLum0TZZFLkXT4i29f2tiMUwIp0BCASPVvE5KlRLXNRo/5LkcuIh
	iUKDOFeVfRZ8nHLmbFwe/E0+qB+IKLBSHFxmbo97mv8vj2oEXgDA/obDFMe+CnCgmvrh0MmCMvj
	x1mXpcOFbUiBegRCz1aetJhaVUh8q19a6z4HBztbaHg/WSOW5+n1CfKUQYP5xN710rvGGU4NrcB
	bh1lWGWNrL/VWTVURq8vHfeoKxYZQ/0/IsQjw01oBXfh3mpojIT8aYeEqlVOv8xRB2CuspMjVrj
	UFgBSq3vgbqopXu6WczTmqJugNTUE0pHHHQYLmA=
X-Received: by 2002:a05:6870:d184:b0:49e:4ed0:11d4 with SMTP id 586e51a60fabf-4a8bb701e65mr2458445fac.50.1793221602376;
        Wed, 28 Oct 2026 14:06:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b77ac4e4sm3068523fac.3.2026.10.28.14.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:06:29 -0700 (PDT)
Message-ID: <9c65a285-9144-494b-b4d8-e3d0deb671c7@linuxfoundation.org>
Date: Wed, 28 Oct 2026 15:06:26 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: Add missing spaces after ! in probe
 syntax tests
To: Jaewon Jung <jaewon8868@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261025075044.1750113-1-jaewon8868@gmail.com>
 <20261028011923.2050009-1-jaewon8868@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028011923.2050009-1-jaewon8868@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/26 19:18, Jaewon Jung wrote:
> Add the missing space between ! and grep. Otherwise, the shell tries
> to run !grep and reports "!grep: not found". This always skips the
> conditional checks without checking for kernel return probe argument
> support.
> 
> Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v2:
> - Add Fixes, Cc stable and Acked-by tags as suggested by Masami.
> 

Thank you. I will take this for 7.4-rc2.

thanks,
-- Shuah
