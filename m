Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53243B6F3
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907084; cv=none; b=J4iudcR4SKGIWbb8iLyy8fRKj7pg3uQJoPFtaV0LC9T0dhyOu4UxTf9Cd+92I8X0a2AmbBlJPh1KlvdUq8kO/34sNumQO276vfo/L0N2rq1d8GfsTqIAJdVowfU/O0nuIkFA8b27YYzzDu8+xjAvg1XfdTlp0+UxmDSbL3knubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907084; c=relaxed/simple;
	bh=MnugXts7y5D535S+D6T/loR1mtSZRGqEmcfdulAt4RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEXVUoGbiQF3AICJsfx0dwx7PNDKDgHzVDVpM5VmspU0nRnhH4dg4WyB97ZbOjghE9m18ZAi0NNxsKQa0MVPVhhqevxRef/TNKNcut8wjCwC/vQHMvxb7GaEcOxzQn25ctXifeaS95YGBbQk0/25iJBcQ3DF+qs64cEfQbSpXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNbvaSVB; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNbvaSVB"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1442650a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907076; x=1790511876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYqPAHe6dDWQaMD5MN6ftRH3n900tUiGNAP8+qEZJDw=;
        b=DNbvaSVBhs4oW1HJdTsV+38blMKvG4y2bLMimGoJt64bWLV5Ljx/ndhEbIUh5aets/
         2a7DAjqgVe/A8INAY9hLQHY1Aqr7NO2oyOjc4+9cO6r8TrTgCiHNRsTBfMNQVJsFTU3n
         kvQUa4fGxf6J5khsdZ04y5dyWwmYyKM6e0fkes0KbYInOJiFVK4Rs4DV6HdTSv3gHwST
         D38pYjMwb4TuWb9D7S+R3WbKgWE1xESQps7rkPWvVJsyFojiajq2xzymHpCJo3dAMzGC
         eblBbmDN5N81kZnWDmdrLul6JRyejG0wHEhPGQcrM1cX7RSGKXD3Y6mDZJoa5N0gPgJg
         BnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907076; x=1790511876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYqPAHe6dDWQaMD5MN6ftRH3n900tUiGNAP8+qEZJDw=;
        b=1XCfppy2odGtdZN9BWTiBK42kY0foBmRGifD5j8tvL8XWHVH43wvSHbo23a/qKY4NB
         aGUySTQpaDYyhQRD/uIBn05p7Zwv5jm7oGzpkpehHAVctGp1b2OoLgLXLlA8A4k4NLn1
         YCW2k19Nj2rnKY/m6h4Ty/I87+iOt0aOQVl+8ucdfV5GXGV+v8ya5kzWwXPzmReR/wqM
         aWIq1tLtG3Pc6uqN86mQF0kd2XLtg5tprVbmlLAXgJv9JNjr8K8yNE1VPHkk9vsCmvgB
         Xwlo6PVWdJAhQ3pDU0Wf+lto3QpAoSJV5RNf5HNof75f51aye3zVPfT5sTnYodweGW+s
         zFXA==
X-Forwarded-Encrypted: i=1; AKwUvBxx6dhqrmFnVpk8olgEH0qXh1j7aacxdBCqaC3VnHAbms5I7ejw/EsdpK1phwxVfFzAR9+h0WM=@vger.kernel.org
X-Gm-Message-State: AFuF++l0VrpjUMk6rCenAPdHSpxCenoj6ERZG3cS6LVs3sISD9p93Ue7
	qbUWDQutnM2hpEaRIV4lGtyZFx0P+/6L82DNAF4qazw5ZJXHlz/bxW0=
X-Gm-Gg: AYBFou1TDmdPj6TK0egR9OxaazXYGfFZPG4tEFqmoFWzpaZAQl7sHK4UtJbRBobPYlk
	PYiNdkTDQGSIu0mISv8fEg8YAFoWwnU9oPPI9Ew4SSxluoK2j+/BaTOSMlSb3WlUFSIrYeMlnRr
	EHfqHWXDBiZwUQEkDT8YA20Rob5EHGr2Ff+kKDmZGvIs7fyalhVfxu/M3W+FJcTxZgpBzSHuZOV
	he2WF7ax0GxG1p0RFLp8itA2a2ZnUsBU+26o8hAIlH6xTaGnXRBH5EgX13kH3nlS/ZI4KGwb+ls
	Dzfnzq9uoSDqKcUbV7tYn1Vxp2N4X19fgLyAbaYagIFZqV5qrHhLuL9plsESyJ1t/V2tKnfVOAK
	EpgT5JruIb7pVgRLa4GLWdfpXIKJ2Quv6/Jj9S/bHVX2JCZsue86VYtrOoMQMHfm7lu6LXIvu8t
	Ktb6f2sPLUBaG/xu7ymmNYDVC7jVTji1mrsIyhVJGk1mL/KcV3jo6NyVf+HBufEYOHlluQpcKAp
	eA52FCghyJDZQdpA2IJfceEyWM=
X-Received: by 2002:a17:90b:5281:b0:3a0:3673:dbbf with SMTP id 98e67ed59e1d1-3a03673dd7bmr2099459a91.59.1789907075684;
        Sun, 20 Sep 2026 05:24:35 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a03bcecdd2sm1173362a91.1.2026.09.20.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:35 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 21:24:30 +0900
Message-ID: <20260920122430.610257-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920103714.47722-1-sj@kernel.org>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com> <20260920023111.2466265-2-donggeunyoo.kernel@gmail.com> <20260920103714.47722-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the detailed review.

On Sun, 20 Sep 2026 03:37:13 -0700 SJ Park <sj@kernel.org> wrote:
> Let's break commit message lines with 72 columns limit.

Done in v3, here and in 2/3.

> Why 256 MiB, not 429,496 bytes?

They are two different numbers.  429496 is where the multiply starts
to wrap, and every size above it is wrong.  256 MiB is where the
wrapped value lands on exactly zero: 256 MiB * 10000 is 625 * 2^32, so
on 32-bit the product wraps around 625 times and ends at zero.

> So, the way to work around is updating the size quota to smaller value,
> correct?

Correct.  v3 says so.

> But why a sane user would set such huge number?

They would not, which is why v3 no longer argues the 64-bit case in its
own paragraph.  The threshold is now stated once, as part of what it
takes to reach the bug: above ULONG_MAX / 10000, which is 429496 bytes
on 32-bit and 1844674407370955 on 64-bit.

> Because this patch Cc stable@, let's make super clear about the user
> impact [...]

v3:

  Triggering this needs a scheme with a quota goal, the temporal goal
  tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
  32-bit, 1844674407370955 on 64-bit -- so it is unlikely to be hit on
  a tested setup.  Nothing is corrupted and nothing leaks.  The scheme
  makes no progress for as long as the goal is unachieved, which is
  easy to notice, and writing a smaller size quota restores it.

> > Bound the conversion, so a size quota it cannot represent falls to the
> > ULONG_MAX the function already writes for a scheme with no size quota.
>
> I don't understand the above sentence.  Is the grammar correct?

You are right that it is hard to read.  The sentence was too long and
tried to say two things at once.  v3:

  Bound the multiply.  A size quota too large to convert now takes the
  same ULONG_MAX branch as a scheme with no size quota, so the
  effective quota becomes ULONG_MAX / 10000 instead of a wrapped value.

> > Widening esz_bp instead would reach the consist tuner [...]
>
> I don't quite understand above.  could you please elaborate?

Sorry, that paragraph was not clear.  It was meant to explain why I did
not simply widen the type.

The other way to fix the overflow is to make esz_bp wider than unsigned
long, u64 for example.  But esz_bp is not used only here.  The consist
tuner keeps its own value in the same field, and
damos_goal_tune_esz_bp_consist() passes it to
damon_feed_loop_next_input(), which takes unsigned long and returns
unsigned long.  So widening esz_bp means widening that function too,
and the consist tuner would change for a problem it does not have.
Bounding the multiply is one line, and only the temporal tuner is
touched.

I dropped the paragraph in v3.  It argues against a fix nobody
proposed, so it only makes the changelog harder to read.

Thanks,
Donggeun
