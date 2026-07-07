Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025A42DFF6
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435435; cv=pass; b=l/OG+Hv+qZDwi0kgr0YPqvW07LJYR0MU7n7bXhl9pouSrnrbb0ECrezDv9HQ9cut2GpCyNF2j+PdGWwW47Jj3murrt8tp+PWCYSZf/qBf4BDmoD7mkShENeZs7lBFs9eaXi9EjjWSqm0bKznIsOyiLm8jB3ACqwIoO2ElqRrMtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435435; c=relaxed/simple;
	bh=6AYnViclv/2FGBWVdRm67Oo2J+NOKAfqV8ACaSZP77M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3XZzU6c7yBvFD8URj7mbKGD69mNwlPoJfXhqmZJlbozbCgoPN/jqXsAdshRSbvc5gcz5elg15B5kGYjCe/QRw11sL4eTdgF1NF9fR6NNG5jZS038I05efbPDzxnLHgE1XtPvxskEsIwTjjNVNYf5N8ER8ICPO73kFcXUMHfuHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qU9J0C9q; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU9J0C9q"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845ea8924fdso4820243b3a.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783435434; cv=none;
        d=google.com; s=arc-20260327;
        b=e8DJhX0E4LBTUSAXv4m0Rmbpdbtdyu2XYVqrqe9ARhCZ42fi5IF2T5+N4AYJwjN6ox
         cD94trScK/aEAh5pbt5rurj96UOJzuHzhuDOyYfrtn4hH/6Hm02ZiBooyrv13SY5kPly
         n3ZK0gHdFaouaAg6GiGtBtBcB3p4qawgy82CCq12t50g4BXUFMbJmouzwCT2vapCNuEX
         xhP5lc5e/9lWwr2phnEhP/HsHmS1CMXciIULdeMKJV8Wn1nI7YiJomJEKISzp8IDP/jG
         fAzM38nNg7ObRTh+LAFXBvRpUnQrX62SQtlDXHMpvGNDGc+EDAwb4a1rUAPAGrchYGno
         b88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tv8u/TrF2GWrJ2FphGLExw/G5HOJtgvR9AbpDmjQITo=;
        fh=OxzXMbyoaFC/uhmwWemfLUqmms5x2oa/8GvYRbMwlJA=;
        b=PV/VU8Evu21WJVFoWmLZgBNCyGyy9mG/IexGWJMnzZZhYj9zFLA9jBXUb24UeZPKj9
         j7ZUA2N+vycAchKD9nvtBVBWMGUYUruED6FUn4uB/JEldYK/dV/DaH4AipQUdgkm55Eo
         epTWCpwTENX+1EQ0jyBFNeooZP5/IUIYDEM6oiyOI+wI8imIYFZ3w+k7VL82MzvNV8BC
         HnqaC+BNDxqCXL6jkgGArwAUN59PDOGb9lP9qNMYeSAx7EBPBRkurhVxpuo0X4tMCZ2K
         S4cRx7pnqoJspz2cLv3cgon0g8u02ib5Qj5WHFLMhE4Ll+LRL/8soRAzFjtgmaFy5Zda
         q48g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783435434; x=1784040234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv8u/TrF2GWrJ2FphGLExw/G5HOJtgvR9AbpDmjQITo=;
        b=qU9J0C9qrQlwRwAPeCF+ZsMVTwcDw5zzq56FUAyp8rqEKPJwCOSJ5eS3wnRNRf9TEG
         y3nRYNGvm5IId+kfyaYxJ1642jGHblNNq3UwPF/U4KBOn0WplPF08HspzBelMxV4aayl
         2/utzH7YGrNP0B6adWpW8JNu47Iz9fn6i3Tp0bz+m0jj2QyS6zlZRUualc1DHU4y5/vn
         cjvo3aTYM9ZmlPPnGVZ+7i26lcvmD6uisDnvxldpQfbYRTWptyuG6S9JeLosAeDgEZhe
         nHJWn3VdOvXEuL8JIs2OaacCwiCHZ+rxDsirPEJDPpp0K8dXcqd4MF7Pwxk6nH2T+74r
         FDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435434; x=1784040234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv8u/TrF2GWrJ2FphGLExw/G5HOJtgvR9AbpDmjQITo=;
        b=ZCINGQpwCTTV2M3UJkgQoKZHVUa8Dun0QgLxBWssLw793uh7fewCCOsmHo4FFV0SSX
         eUlpy/0uWPl13TY9wa4hri/r0cgegmprZpAHTU4V0cGOCCAc+uJw4q5nHRXnkmC4fKuJ
         CXBwRi3LZydpyGlvaCxKNQVmM3AQ/9iR4e+BWL5LFVLi2cJpzw9qdv8tpErwlN28dqG3
         aR0dgO5TfSunDoBrV5lUI27DXWF/2Shgkq69nPdFrY0vuGgh/J5RMtwLrVcd9uKGWe3z
         BAojF5wPdgHQmFI1UxHZwGK6j6l5zNm2p8guhGorsJCrzu1+vLbr6buy1oRedpDrlmtT
         Fbxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp35uJcLAgf52jD+WuphtWIowELY7zWH2OKPG7xBNlpWjcQNx/be4cVfvF0fEn2PR0vOcOkEX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfEiguudqisOSeV7Hbpsu/KREgKY4jnl5giwtq3s40tEm2bRH
	gDQFMkGgc057g73GszAUhEtaQgbaDSYu7q0evnWUc5Un34SsBP4O/KVKKUycpu/IWvtqrmmgb+q
	XFNXNSy3TKs9+6pA//uefQdMjBSHtP9Y=
X-Gm-Gg: AfdE7cngq/m+NlLPsFFd2MJP2Ujfb8lCOITiN5lFnDNgBneVGgfQ0D1kYnhSkxuAS0i
	FC0uG9ds2fO701CzAIflHhFPW5cNHhVyK8VYISmxTTMESP5JkjOIQ7EDezu0OY6DwhGeGDb3fwV
	Cj9XT/k+ffQIUCQPtE6/mdkKf9x0AYpeEvS7yhu1O7TtIQW6IocEN00ofzmSyqAvF6kW0A/J2W/
	R8dJhdxUauUm811tQBt4p/w4Y7hMhx8XtRw7BZIGCx2a9eRBljX3j8INPUKw0EyqO3KWGTU4pPe
	3KnXK6fb5me7ZewnLpF0ZyOi3Q==
X-Received: by 2002:a05:6a00:1bc7:b0:847:980b:f299 with SMTP id
 d2e1a72fcca58-84826bb460bmr5447444b3a.4.1783435433732; Tue, 07 Jul 2026
 07:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
 <tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com> <20260624200535.GA132-beaub@linux.microsoft.com>
 <20260706160650.2791767d@gandalf.local.home> <CAJJ9bXzJpYRE-NjOjiArpuJWGnFXr+jq7ukbEEdEhK9YPCbYrQ@mail.gmail.com>
 <20260707104205.582db193@gandalf.local.home>
In-Reply-To: <20260707104205.582db193@gandalf.local.home>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 7 Jul 2026 10:43:40 -0400
X-Gm-Features: AVVi8CfpxD2hcyjt1UC6coacnc6d5fETrGBxov8Mb-FitbiVxyPDp9IVFaTxCOk
Message-ID: <CAJJ9bXy78yKmOb+x-THk4EwJxY=0si04YAMtmOu-SzarVJwRBQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in user_event_mm_dup()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, XIAO WU <xiaowu.417@qq.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Ah, you're going to send a new version. I'll drop the one I pulled then.

Saw your pull for-linus and I was just about to send a separate patch
set for the second UAF with a ktest (as 2/2).  I can do either way,
just let me know which is easier
