Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC223504B
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783132552; cv=none; b=fQN49ZsZJOtXEu7VCijzwGP6lQ/icfq3blReCH3nI1fNbtIzV0kpUK45VDlWFVW2hi671uoSipAdayyVuyvjvD1VgNaBLdQUBgIs7OxTgaU8hTEAX79zIlr/4cluvcKkK5ikJUqXZsplAspR05NXMH9VTq+VWfVllrWwtrYETVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783132552; c=relaxed/simple;
	bh=FgKUqeB0lXHa9dP79O/zC1viwyzBYQ+jYUH5FxxbGd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P31z2pu8QqDjAIPY1rOWOIuMPH/dOGfy/ul+hvY7AgMsHTIBSaDhrJOptsOC78TlJV8Y+VQktyf5ppbh2cgPcW9AFEfqRame5p4cfRhelBQqL6jDPg0EyKYTUnN1dnt4n+/ARj9Nl1vhoU1h3mGCSzpXnJkyOOIEIXAjw1bfgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ebYCYNH8; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ebYCYNH8"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb63dbd229so600116a34.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783132548; x=1783737348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHvJZjVQxTmWKsTA4qLP4x++RU/BtpzZqPpEeqR7dW4=;
        b=ebYCYNH8I0S0Ev7Hi94e6/0Va+4r+jHv7L7nfACc+4rLiANvFR0fB5SQ1fJyCo+UxA
         pOpxDm5+yqH8uuWUyGp/cOJu82ESOI9mei8XsRCe2fAO6EiS/K80aBBDx85ek5BB36Fo
         y7UnFrdP6X8H4xXlzi4kudN3471Pxcg6FXxMFIvZIWaQxcI3wC92e3KUTrvXlbRMKSFo
         I0vh/siGWY5UJUDjxopCtmRdO77+0lP2uo57f3ouoAq/A3rYg7y9bL8BhBULFxXgYW/g
         MUljihVZUOqsGBcHJwfvLvnOrb6+t4LGefoPumg03yyR63nYUqEj4MvWNh3S3ie3DhIH
         D6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783132548; x=1783737348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHvJZjVQxTmWKsTA4qLP4x++RU/BtpzZqPpEeqR7dW4=;
        b=VVkcvW//HJn+DF038iqszPqPkoeXvzVdWLi0z7J+HS4pae9uKcMARpveu19qOVIBlG
         vgqQSGCXv/YOD7oAiApihZ0uuGDgPl5tOc98KypRpSeJYha2ufN+0OfipKrBWh1mU5y1
         dScdIQ8GIyFoJ1b2ULIJZkb8aY+FR5c61qEo7+3wC7bSUd0HhKhHgxk0RVPe8ig/FqDE
         W8eB7wK/aLE12BVUxNrqHC1ttHRjIbN7SCcp8MHMj/2FPkIevVH8TfX4Dh10Cgrcljg4
         2RZEcRQV91pM59gON09v3c5K04/i8FGChOoUMbmA3ZepTF8W/IwROilx9Los/k/Slqg0
         aR3Q==
X-Forwarded-Encrypted: i=1; AFNElJ83YTe6W5uaQjI9YiCZrRkl9U35+qLKaEnoPvthCjzXi7z8haeNfEkPPcYAjrW1VGEQb8aHE2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhV0rvulugz4S60lrMt2KLITkAk3x1RijakeZqCPW2gJCcBs+
	1ofbdawF/wGB7f0AT6UQuchIjgD7Sx7/pdz6m1JXsH8Uo2AO1YoBIGL9aeR0N9XYpJ/6kIY9NA3
	z/u0VOq4=
X-Gm-Gg: AfdE7cks8SYXb7g6MVztQgPBs7ua0m4KAGd45+79/5a+jADkfkeiJxIzdIJViN0DoRQ
	s2bWVn9C3HK8nFtDy7hxEaOGYyerxzVY6xDwTWYU8wJ7uf9IZLFvv8q6VE5bs7Xh3+95mtBW/bC
	f9H84pu4tqaAwl+UCx+sT99SevVxFkZHMW4lZy/E3Ip3Aw4aalDsQc73LQw2bWzOCodH3j/1pew
	PpAa9B36HaE0S5CXrH1cxHO+smduyuqd6lMAy4QEZBzsA+QLvp2YoXdT9s9QOsa5Qzdf6SJgG//
	PW9tqVLDeEJh9x9wQL8fAmcVDVhDpjgxIXIub13ym8yLUu0b4X0GWpCfK2GA3ehrYesYG1O7duM
	JMB/+8cqUS7ezmq0TvIuM7//DnKiLIQqiUm+D1BMCr9CMkxrpbUySoSRE8wn7p5z84uyGiHNH/Z
	cQ3YUK3wIPsEz+7k26zDtHKKq1F9I3q6O+Swx13Vg+VZTK0yv8xxDAMMdBQHpjvY0OGkmeZQY=
X-Received: by 2002:a05:6830:82e1:b0:7e6:d003:929b with SMTP id 46e09a7af769-7eb80e10000mr864304a34.1.1783132548594;
        Fri, 03 Jul 2026 19:35:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54292d5fsm6325595a34.6.2026.07.03.19.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 19:35:47 -0700 (PDT)
Message-ID: <eeec321a-fd07-408b-9d64-c4d65ec92935@kernel.dk>
Date: Fri, 3 Jul 2026 20:35:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 044/108] block: invalidate cached plug timestamp
 after task switch
To: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Usama Arif <usama.arif@linux.dev>, stable@vger.kernel.org,
 patches@lists.linux.dev
References: <20260703123236.3139759-1-usama.arif@linux.dev>
 <2026070315-stable-reply-0015@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026070315-stable-reply-0015@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 8:05 PM, Sasha Levin wrote:
> On Thu, Jul 03, 2026 at 05:32:35AM -0700, Usama Arif wrote:
>> It looks like this patch was backported, but the preceding patch [1]
>> in the series was not bacported to the stable branches. Both this and its
>> prerequisite have the same Fixes tag.
>> Not having the prerequisite will result in a NULL derefernce.
>> Could we please add [1] to the stable branches?
> 
> Now queued the prerequisite fd38b75c4b43 ("kernel/fork: clear PF_BLOCK_TS
> in copy_process()") for 7.1.y, 6.18.y, and 6.12.y, thanks!

This is a problem. Can some light be shed on why only 1 patch of the 2
got applied? This could lead to big problems, which seems to be the
case for this one in fact.

A Depends-on could be used here, but it's pretty hard for a submitter
to do that, as the sha isn't known before it goes into the maintainers
tree.

-- 
Jens Axboe

