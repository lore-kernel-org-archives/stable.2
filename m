Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D399222590
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786797747; cv=none; b=dnAs/DHE3dxgGk2lbxDXJR42sQ9H6o+qAxzCpGdU2qeAKXokAlAFkItZ/3RsOaik/g6MQlktZCNIElJIPyxaM++CTRdOKR/IBHi60DRvcWF7h7Rx7llOt6zEufPUzv13bIged6fmwwcSxz8B+IbBDKjagFYVqkn8OyHt+65wbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786797747; c=relaxed/simple;
	bh=jgIkk2nn1A+J6ReaNKKTED+htmif48oSt3csjhKCSwY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DUTaUBCDvEQo6BWcaQ3enw5DfAoft09bpO9dU9S2wLqwWGgXLwD4HwgZO4ovQm9dbC92D4El/E9tZs2YdXMVQgvZ0LMeFpVRPdXIQdMDU73xtJgUJn9xSmEhGEdIX7P2aByD5dS5QZ7CCV9ubmFOd1f3AO/r8HFlFer8NZN6LDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=exBIIGsM; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="exBIIGsM"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f3fd905828so91634a34.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786797745; x=1787402545;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jgIkk2nn1A+J6ReaNKKTED+htmif48oSt3csjhKCSwY=;
        b=so8tsaACRxBgiPuxTtSUQMLhnET/XisnDsRuSRWrtCr4kPwX0ztPeLb/b+5JBXwOuY
         JVD9GHnBpb5yZxGcg9Bw4PzlBmVeD7fxnk3OtH0bPJsdCYYSToOlLP4skW2htSJvLfh/
         EAq7sEy630nHwypkwKUmTkGvwrtrUg5lH/PsWDrh3GAHsLWm/T/4veXMFljH16+vNiNx
         gcoh4nNkZotIjFO6S8nqS7VeIcvRh+M/siCnDHI7UMioMcXUMsH7OoHPom6aMG2HtkU+
         QEiRxfxEtB3gpYL1am1oy4vNZAQSOfJ8j0/6AEWSUGxQq6jQrcXgAa2qszzbqN4knNqO
         p9iA==
X-Forwarded-Encrypted: i=1; AHgh+RoqC9hRyXqWbnUtkM1smHSH55wTzTPdg/P7AoMW/4Tqx0V2iF5y8lGU+yzWsVQpGs2WZ4uW93Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6i3kiCmZceJUi/yROh6kSK88OkIyW8j0tBEmwcGmM96re0l/t
	1F6vq4FolZVaFZ1qblojiIVZZJg8z4LsPO7llrtFkpgtrmRqqyS55Uwp
X-Gm-Gg: AR+sD114FK7lWnlIzmhXmascUgsKfdT9aNp5UliVk8Rs/E31erjm0jOhh9R8yceDdHb
	795mim8LW/yhYbYi4YQnXB3at0cGqYs0ccTYSmOB2Y5+FwI82anUMiJqHfM2818Mr1VjQ4xPYfb
	q0eHYzwQNe87h24Fgqe3ygz65wuSQC/JZ3BdwpdbQJCt7MhHwqTRjbkkboNefA7EODSo1hAH5ym
	IjEDlHw6oQRD5OGjP5PM8sjTZ4OfZ0az8bONiZzPTiIkHYigTHKs3T+r67ivO24cEO176OmNwq4
	r3ow/68BCaWDb4yBbKwBKRs8La43ojg+IuTpsX6BllJAj22rrcappqEZVrgrXbPxEobFL1RsZBr
	yq4MyQYJuIfO/41r5A84fLKqKobFXe3/eueamZEsZrHACrCIIbkdC0kSIYgcPRsfnmq5f8j4ezc
	jvEVwFNx3Rnvl0+C8Y0GoH0b60Q7fZ+ZGDhpIzslcQVbcC3YCfpjPysslQuC9cScg9cLwYxyW09
	f/5yCqX2S5OW6NPbPasZxUdi0/DkU70T8kPpcpDBOHfem4nMO44Eat2fzRsba8s8YQlhHI=
X-Received: by 2002:a05:6830:2708:b0:7e9:cad9:4bc4 with SMTP id 46e09a7af769-7f3de64c4e5mr11379114a34.7.1786797745079;
        Sat, 15 Aug 2026 05:42:25 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e86a2271sm3943706a34.27.2026.08.15.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 05:42:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0DF760791;
	Sat, 15 Aug 2026 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786797742;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jgIkk2nn1A+J6ReaNKKTED+htmif48oSt3csjhKCSwY=;
	b=exBIIGsM8usAz8IR2N1Y8sTrwQmlqKQKi6I8tES9rqE3uu2p4mvf1yIZpXqHK2KhvmMzR8
	PWzwUpbwYFyKRQLopIsffcHmi1jbeIr2U9Q9W5FbKe7vXhJjedUWw5AsDVo2vclAaM8/fb
	CJUQ0jD/28sdi2WCSH/wWiMJAruSFjrP11GhCRC1xkGndphS2KRXSzLxlx35mroVJ26uMr
	i4v5ghw5jnR3AgRl66yoBdkba8wEIr7jGVwuEZUGh944myq/IFDqsm1Z+tQacHky80bkEY
	rEx8m45SAa9NFt6r7Hu4Zg1yqVzcAJadwC/0gQjkzK4Z7nP+efEJ3zfydpL41w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Aug 2026 09:42:12 -0300
Message-Id: <DKPIXMNLF4IJ.11CR3H75W5JCX@marliere.net>
Subject: Re: [PATCH 7.1.y 0/4] selftests: Fixes for BPF
Cc: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?=
 <ricardo@marliere.net>, "Maciej Fijalkowski"
 <maciej.fijalkowski@intel.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Jakub Kicinski" <kuba@kernel.org>, "Michal Luczaj" <mhal@rbox.co>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Jason Xing" <kerneljasonxing@gmail.com>
To: "Sasha Levin" <sashal@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, <gregkh@linuxfoundation.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?=
 <ricardo@marliere.net>
X-Mailer: aerc 0.21.0-147-g86b4df97981e
References: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net> <20260814193000.20@kernel.org>
In-Reply-To: <20260814193000.20@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Aug 14, 2026 at 11:33 PM -03, Sasha Levin wrote:
>> Please consider merging the following patches, found through openSUSE CI=
.
>>
>> [1/4] and [2/4] are for test_xsk.sh:
>
> Queued 1/4 and 2/4 for 7.1, thanks. I moved 2/4's [ rbm: ] note above the
> Signed-off-by block so git parses the trailers again; the diff is untouch=
ed.
>
> 3/4 and 4/4 need a v2 - the [ Upstream commit ] SHA in each of them is no=
t a
> commit in any tree. I've replied on both patches with the correct ones.

Thank you!

