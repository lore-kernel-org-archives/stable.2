Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124679;
	b=S755RiMl2CkLhYc7sqEOgOtXHYJbigt65TgZTA2Trbt7E/1dPE+xVRsvaoXCM9S4N5H7
	 yW6zRAEOawSbIKZMNvtBJvOeGJxELqyjpeH0aY8bmI1szzTIX8GUgqqkSP5Q2cP4aHnnj
	 ssuGwiSWZDnjV0uG5mWXcZYMbe1F8gnRxpVXg36/FgA+pXmZPzkitxrm/8tn09BcbbGIV
	 BAnWHdjsZSSno5YVH84iOKS6goPkGzE8njC9tGmoqF5Z9AJRi6niqWtiCibuIPkvHEPr1
	 SrpYwlLE2UXbwk2gHDMFZCmPB7EcZVmB19rWSMn637vwmrsu0cmewVuvBpPrJhiibjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124679;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bS6Nvy1g1jBhJA4aHeDMQWCoFHQ0poVPxAlc9gBdDwY=;
	b=oTnjMBbmQ3jor1WQEIn0KCrtUlWTqpyt1ZwZRM7vQZPA66Gb0snd/jaU1jVZu5n8nS4g
	 2wpgrgm6El1YRmZLwTNWXIhDzUfidizI4ZLFLcjE7DGHOc/eena/z94Ow2dHacgIkKBlG
	 BDBiyNmQ7wyBuKDx0sr6fChQzgJ5jvWFXggAI6MQiDWMWEzCxvhZBYwY6AchVHqlwMJIC
	 Npqykss1drZ5gdA1Wg4sksRBESEORfcRgYD++AV97elH65tluIWSsDw59KUuEM2qiP3tl
	 M+gdVrKLbQtaf5vexaGQIfBT+3bu86iIQGtfgDhMtH7JRqeQFvtMBNyqaNYS0y7fvQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6A606A323
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8D6A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso1418465e9.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124677; x=1793729477;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bS6Nvy1g1jBhJA4aHeDMQWCoFHQ0poVPxAlc9gBdDwY=;
        b=NUQ4vnWpijrxbe7XojZH6I4TcoEnFalJfpmy/hhdA0oDzJ3jmgm4tdFYSf9+4NKZ5q
         8zgufWXv7Bq4No71008MShai0xzESKMQDoiZAPh5zGR2PXFoRaGgOUt4/ZRZtVQi9xmq
         yBfg713hODcGq+eLhf4jsEg+Ry4faHRw6rcr+pT4CN2WJ5B4B+oVBMMzs7z9Fj1YHyLv
         iPdf2ztd0FGiYLO7wyKE1vXoEiAkkdgwdVknLHzF2QVgQcvG7mlgS93C3ICONcKMGOQJ
         uaZRlIMDtEvE30x8DjZ6I25S/CHsmDLTtVFJKzMMH2CwyMC3lpN0u9gJqniie0GFNYDD
         gjhA==
X-Forwarded-Encrypted: i=1; AKwUvBzssVopNn+IGpY/rxsdyuEhrLqyzLFZwBwaFG5WnEbE6yxsMOo9xPYJg47n7uHut00s1IbphaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJBzRJalBE6+uVn6foqd2UWHBjD5sWC/jJXhaYQc5EAxc0dm/Z
	N6MXMntZiGCCQCwGHtNXXyS6bpj/3n/8J6ZvDDl4UCZblU8KnHzUt4Uh2qege8xUbw==
X-Gm-Gg: AYBFou2xmwAu+Njgth6APTz1rSHKxR9G8KvVRgnfZw/U4rJTABRYshY6dhbW+3ieYmq
	+WbVmpJK8d+iGca88t/ghfhwz5h4Lgse5jYruAj4HyYU9Hpy6dWuHetGoZBpXVrph16fsBNexgV
	+PQ9rrR7eJM9iwI3lSdKbqRlqg1+apyROkm2hisifchP56a1kPjOLPIXPfKJQhx79mYPFTBHtuX
	Ch447hpgxJBeOqeqPG4eCt4lGyikplsRYc66z80IBBxjvmInEo307zDTWOFjqMowMM30IUntXRO
	NnnmB4ebcVeI9sorCQs6vK5H5BZmL1D3E+LMq2XtlUm8ugZr7zMuqfrKgCBgk+BzYjamPo8XHvc
	eGeL6M0SMpJTZ6msRUBqYA9Q64CIYpoRy4du0RfOFi+B2mjOlUXUam9Fv3J2d7YPmymY37klsFa
	WscCIsPCT7R6g6iqOzcDYuams/1fKlzDbggyo50+r+iVP79QhzyOj1O1tvlAjPjltchmNWBtMfc
	IN4NEgn90jd4kYPVoz4u+Yu8o+CG3i7mpMgLqTLs/cdPLAkHvPF1oaQ5EaygeyhQQmkKDDOpKVD
	UJ+2s67iq5XUgd5kMu6irEJ687/IGOGuvirPbnc=
X-Received: by 2002:a05:600c:524c:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4a35ac8c0fdmr214486665e9.7.1793124677050;
        Tue, 27 Oct 2026 11:11:17 -0700 (PDT)
Received: from [127.0.1.1] (84.124.213.91.dyn.user.ono.com. [84.124.213.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a93123323dsm5491625e9.14.2026.10.27.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:11:16 -0700 (PDT)
Message-ID: <6ae0e944.b6db0abd.16b13d.d261@mx.google.com>
Date: Tue, 27 Oct 2026 11:11:16 -0700 (PDT)
From: D. Manresa <dmanresa@gmail.com>
To: antoine.pichot@gmail.com, linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org,
 dan.scally@ideasonboard.com, hansg@kernel.org,
 andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
In-Reply-To: <20261027132637.540222-1-antoine.pichot@gmail.com>
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
 <20261026111032.88355-2-antoine.pichot@gmail.com>
 <6ae07c65.e52dcaf0.293af3.e7d5@mx.google.com>
 <20261027132637.540222-1-antoine.pichot@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

On Tue, Oct 27, 2026 at 10:26:37PM +0900, Antoine Pichot wrote:
> Could you please try the two patches below, the first alone and then
> both, with your 150-frame measurement?

Done. The swap fixes the link completely on this receiver. Details
below, but first a correction to my own numbers, because they are wrong
in the archive.

Correction to the dropped-buffer figures in my previous mail
------------------------------------------------------------

I read v4l2-ctl's output wrong. It prints a line roughly once a second,
and "dropped buffers: N" is the drops in that interval, not a running
total; the suffix is omitted entirely when there were none. The column I
posted was the last line of each run, so it was the drops in the final
second, not the drops in the run. Summed over the run the figures are
some fifty times larger. The CSI-2 error counts came from dmesg and are
unaffected.

With that fixed, 1/7 alone at 30 fps, three 150-frame runs:

  dropped (sum over run)   1181    388    926
  CSI-2 error lines        >=4996  >=1931 >=3785
  elapsed for 150 frames   47.0 s  18.8 s 38.4 s

A clean run of the same capture takes 5.2 s. Error totals remain lower
bounds: the printk is rate-limited and I add the "callbacks suppressed"
counts, but the suppressions of the last partial interval are never
printed.

The divider swap
----------------

Your 0001 removes the problem here. Every run: 150 of 150 frames in
5.20 to 5.24 s at 30.00 fps, zero dropped buffers, zero CSI-2 error
lines. Thirteen runs. Readback over i2c mid-stream, with 0x0100 = 0x01
confirming the sensor was streaming:

  build          30b0 30b1 30b3 30b4 30b5 4837  link_freq  pixel_rate
  unpatched      0x0a 0x01 0x4b 0x03 0x05 0x19  240000000  48000000
  1/7            0x0a 0x04 0x85 0x01 0x05 0x19  319200000  63840000
  1/7+0001       0x0a 0x01 0x85 0x04 0x05 0x19  319200000  63840000
  1/7+0001+0002  0x0a 0x01 0x85 0x04 0x05 0x1f  319200000  63840000

The only difference from 1/7 alone is the two dividers, with the link
frequency and pixel rate unchanged, so this is the VCO as you say and
not the link speed.

0002 adds nothing measurable: ten runs, the same perfect result as 0001
alone. 0x4837 = 0x1f is confirmed in the hardware, so that is a real
null and not an unapplied patch. It does no harm either.

Why I ran more than three of each
---------------------------------

Because on this machine each stream start is a lottery and three runs
cannot see it. A run is either perfectly clean or uniformly broken for
its whole duration, with nothing in between, and the unpatched driver
began failing later in the session too, so results taken in blocks are
confounded by drift.

So I interleaved: unpatched, 1/7, 1/7+0001, 1/7+0001+0002, one 150-frame
run of each per cycle, swapping the module every time, seven cycles.

  build            runs with any CSI-2 error   stalls
  unpatched                1 of 7                 1
  1/7                      4 of 7                 3
  1/7+0001                 0 of 7                 0
  1/7+0001+0002            0 of 7                 0

Pooled with the block runs: unpatched 3 bad of 13, 1/7 7 bad of 10,
1/7+0001 0 of 13, 1/7+0001+0002 0 of 10. The +0001 build was also
re-checked immediately after the worst runs of the session and was still
clean, so this is not simply a good patch of time.

One caveat for the record: this receiver intermittently fails to lock
even with a completely unpatched driver, 3 of 13 runs at 30 fps
including two 60-second stalls. The Pro 7+ has a baseline instability of
its own. 1/7 makes it far more likely; 0001 removed it entirely in this
sample.

So v2 with the PLL table fix before the index fix, both Cc: stable,
matches what I measure here. Send it and I will run it on this machine
while it is still with me.

2/7 at 60 and 90 fps, without 1/7
---------------------------------

The error count follows frame starts, not the link. The link is 240 MHz
/ 480 Mbps at all three rates (0x30b3 = 0x4b, 0x30b4 = 0x03 confirmed by
readback), and vblank follows the mode as 2/7 intends: 1244, 380, 92.

One module load, then 30, 60 and 90 fps interleaved, five cycles. That
block fell entirely in the bad regime, which is what makes the rates
comparable:

  rate    errors per frame start   errors per second   mean dropped/run
  30 fps          3.62                   104                 867
  60 fps          3.70                   204                 517
  90 fps          2.72                   222                 262

Per second the count doubles from 30 to 60 fps over an identical link.
Per frame start the three collapse onto each other, and 90 fps is about
25% lower per frame while carrying three times the payload of 30 fps.
The bad 1/7 runs at 319.2 MHz sit in the same range, 3.5 to 4.6 errors
per frame, so the per-frame cost of a bad lock is the same at both link
frequencies.

That reads as a failure to lock at stream start which then persists for
the whole stream, rather than anything accumulating with transported
bits. It is also why errors per run vary by two orders of magnitude
while errors per frame do not.

On the cover letter
-------------------

6/7: I would rather re-run it than have the tag carried across a rewrite
I did not test. Send me the v2 version and I will repeat the clamp sweep
and the photometry while the machine is still here. If v2 goes out
before that, carry it, since you say the result is unchanged, but I
would rather earn it.

Thank you for the pixel_rate explanation. I had taken 63840000 at face
value.

7/7: I will answer on the orientation in a separate mail.

D. Manresa

(Written with AI assistance, directed and reviewed by me.)
