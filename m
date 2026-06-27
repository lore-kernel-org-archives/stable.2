Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C126FA4B
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782526544; cv=none; b=JG5mBj8ouyI99H4HhDvslXNCAQPuqNJ6bdzW0IMM3pClbwm2gCBaenWIqftnOXtp9ZwNZFKCfyKPWwU90jjjQLPyxs2216ydldz68+5NYpwb9TLOy1t9GQpgaCzSUTqW4ApiySTvS2hMWx3ExGmXUmj6YN/IeSLj3VDa4UQWt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782526544; c=relaxed/simple;
	bh=oRvp5fXAO2MlKWuwsutOGCIB1PAeqmUsWSR2JOByiZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMIBCTrljUfr/PeuW4Nr3/zfpB1QUNW41buzMAHc1kumpxgKeM2lvyu7WeUK+47YYIUGs9noXSJG5gUa0TZIJM30xkGP2Z+54gQaJig7MM8mbUXiU1yd4Dm3SL8fq+3Sg5+gzu6SCoKPqPEUIPve6DIQikeGamFkNQ93xMba8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9rh9R0V; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9rh9R0V"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-139f1dfc9faso68713c88.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782526542; x=1783131342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qYdqMBQIyUYkp9MXXFCrYIaKaa19JeYnFWZHcVVqAhY=;
        b=I9rh9R0V28kExYZZt6T6Z+mzS2iDgNIJ4rV5w6S2n+vbJoGMxqMrM+kKvSNeyrPqNT
         oJcCm4GPZIHK7Y0GIWSjEmb4w+J7GpnxGSTQUzhZVgT8A80Ah1s3VEw05fxxqe3mh7EB
         WCkYmCnHGqb80dQNVCJ6yYv/U5n10gEMvNDjfJ2aYo0w/fmR6sJ807VI2Ph+aJw3RBUR
         tqMHqNnqaEDW+/Wi30FU1vn9CJpxRM6d77h6Qp7ANIcHqW2tsmQTlVWdZpNWHVGRSikr
         s5Pyci3DHenieqyD5P2JSHNp6SKFA7zk02TyUViQmOquZc0kAM2/7KrWG9IRwwiromB5
         YsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782526542; x=1783131342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYdqMBQIyUYkp9MXXFCrYIaKaa19JeYnFWZHcVVqAhY=;
        b=pRHhqfcDttW7PXX9Sf726m30GMr/NG90AFf+mSQOtYZsNz40qS7JmLNAINSJvzByTe
         43r/vW1ZG4rZAheXzRvesFdxKI5R4lWSaT+hnqyJON3KAewaziHHpoxDPawj64DwyySq
         f+a3RdUIl5ujs8/klTqzXt+8YbytedFmV7fpLww/1TdpXdcFflNqOisZYFB0KeizGlpv
         nRfyWWPkldQihsW+/e9Ny+s7H7kBj7xSiOYRDBQQTcw3Cd0s19LCRmjsQcEy8BG1L67q
         cwdJtUa/861iBhKdr0y0k3F6rrjCEuLNXmGtOmQJK0r7HB9CsNMGTZ3OQeQDAa56zdYh
         MU2Q==
X-Forwarded-Encrypted: i=1; AFNElJ90T2l+sV1anfw5ESl7ogtaN5aJcpZP7fNUpM3xxSU72bZX5JN9UFB88O79yYQ4lqvwFoarpxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5U+pk+GssRgfwWNo+P8Mt12eU0pOPjL3DaxEHiMGm4kIf/fh7
	yfmrUzwHMLekcJJ8bbsXVnckz7e2USJMAh9BUXX49JYGyIdc/tnmsCA9
X-Gm-Gg: AfdE7cnOaUjskZdk4jj/UMBogMOE4EaNoziP+pr41kl3X9w4p2GVXS0tGJ4MFGxx3G+
	PNKh7WU9mu+3mfl2EtDfK4yDDmkL1zuFNIa8MeKkb7DKwSs4oteZfRMcRhP6d/292LDFbBFv0NJ
	0auhOktj92eQThIdLMvEAw0Ee2DuspYYx16z44iFPXYNEbjzQHg7toGPzv/ZwGyh6+aHxC6fDyh
	9mbdJY8/KxEcQI5tf6+gHdJUX1YKjQXXSCJq9eOyaauHHwJLScpGFuu/l5edTq/MrTMUk0fi4Ca
	3ocjZkUqnnDGRMTMXgDpY5UT1dxk+atS+jGLfvu3AaZuGZhjkHW4I40Mz3NUukuW4xd3tgIGIz3
	7BPc981+fKkT12USKk9/XHfa9KE/CULIeu9LiJqL41s9C4JAUTNWjpAjkXBqJGAVHWPN2mFtHJg
	uxScY7zdu/+kt4t4Bi4kB7KlhqQ1eE4WRb3UfA2K6/yXBDFOEoXlwXxA==
X-Received: by 2002:a05:7022:523:b0:139:ed5d:5ca5 with SMTP id a92af1059eb24-139ed5d5daemr1548393c88.46.1782526541877;
        Fri, 26 Jun 2026 19:15:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3348:4970:ea3e:6159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e42338f9sm9853005c88.0.2026.06.26.19.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 19:15:41 -0700 (PDT)
Date: Fri, 26 Jun 2026 19:15:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Message-ID: <aj8yGUwvPqiYk4hL@google.com>
References: <20260625125613.243729608@linuxfoundation.org>
 <b7bd471b-e9da-4bfc-ad1d-24b378bd1e44@pobox.com>
 <aj7RmyBck8EkPn_s@google.com>
 <ab7df7bf-1b30-40c0-9463-a469abfa2bda@pobox.com>
 <aj7r1Eqt2SEnWsMZ@google.com>
 <626fc564-6f4b-430d-92f3-653981e3dcdd@pobox.com>
 <aj8WEfam__6fnNuM@google.com>
 <2b4c3bdb-5dcd-4834-9ee1-5a9a75ab4815@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4c3bdb-5dcd-4834-9ee1-5a9a75ab4815@pobox.com>

On Fri, Jun 26, 2026 at 07:09:08PM -0700, Barry K. Nathan wrote:
> On 6/26/26 5:31 PM, Dmitry Torokhov wrote:
> > On Fri, Jun 26, 2026 at 03:23:12PM -0700, Barry K. Nathan wrote:
> > > On 6/26/26 2:17 PM, Dmitry Torokhov wrote:
> > > > On Fri, Jun 26, 2026 at 01:41:38PM -0700, Barry K. Nathan wrote:
> > > > > On 6/26/26 12:56 PM, Dmitry Torokhov wrote:
> > > > > > Hi Barry,
> > > > > > 
> > > > > > On Fri, Jun 26, 2026 at 10:56:21AM -0700, Barry K. Nathan wrote:
> > > > > > > (cc Dmitry Torokhov because this is related to two of your commits)
> > > > > > > 
> > > > > > > On 6/25/26 6:03 AM, Greg Kroah-Hartman wrote:
> > > > > > > > This is the start of the stable review cycle for the 7.1.2 release.
> > > > > > > > There are 21 patches in this series, all will be posted as a response
> > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > let me know.
> > > > > > > > 
> > > > > > > > Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> > > > > > > > Anything received after that time might be too late.
> > > > > > > > 
> > > > > > > > The whole patch series can be found in one patch at:
> > > > > > > > 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
> > > > > > > > or in the git tree and branch at:
> > > > > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> > > > > > > > and the diffstat can be found below.
> > > > > > > > 
> > > > > > > > thanks,
> > > > > > > > 
> > > > > > > > greg k-h
> > > > > > > > 
> > > > > > > Unfortunately, 7.1.2-rc1 breaks the Synaptics touchpad on my Lenovo
> > > > > > > ThinkPad T14 Gen 1 -- the pointer no longer moves when I touch the
> > > > > > > touchpad. Potentially relevant line from dmesg:
> > > > > > > 
> > > > > > > rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3471-020, fw id: 3972349
> > > > > > > 
> > > > > > > > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> > > > > > > >         Input: rmi4 - refactor register descriptor parsing
> > > > > > > > 
> > > > > > > > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> > > > > > > >         Input: rmi4 - fix register descriptor address calculation
> > > > > > > > > Both of these patches seem bad in my testing. Either one, individually,
> > > > > > > causes the pointer to no longer move when I touch the touchpad. If I
> > > > > > > revert both of them, then my touchpad works again.
> > > > > > > 
> > > > > > > I have not yet tested 7.0.14-rc1 or 6.18.37-rc1. However, the problem
> > > > > > > also reproduces on current mainline as of this writing (commit
> > > > > > > 51cb1aa1250c36269474b8b6ca6b6319e170f5a5).
> > > > > > Could you please try applying this debug patch and send me dmesg?
> > > > > Sure, I applied the patch on top of mainline, and the dmesg output is
> > > > > below.
> > > > Thank you! So I messed up and "Input: rmi4 - fix register descriptor
> > > > address calculation" is totally wrong.
> > > > 
> > > > Can you please revert it (keeping the debug patch) and try booting again
> > > > and if the touchpad still does not work post the dmesg again.
> > > > 
> > > > Thanks!
> > > 
> > > I did the revert, while keeping the debug patch. With this kernel, the
> > > touchpad still doesn't work for me, so here's the new dmesg.
> > 
> > Thank you. It looks like the firmware is a bit sloppy and the new
> > tightened checks are tripping on it. Please try this patch:
> > 
> > 
> > Input: rmi4 - tolerate short register descriptor structure
> > 
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Some touchpads (e.g. ThinkPad T14 Gen 1) have buggy firmware that reports
> > a register descriptor structure size that is too small for the number of
> > registers it claims to have in the presence map. The remaining bytes in
> > the structure are 0, which with the new strict bounds checking causes the
> > parser to fail with -EIO, aborting the device probe.
> > 
> > Tolerate such short reads by dropping the remaining (unparseable or
> > 0-size) registers from the list instead of failing the probe,
> > preventing the driver from trying to use them.
> > 
> > Fixes: 0adb483fbf2d ("Input: rmi4 - refactor register descriptor parsing")
> > Reported-by: Barry K. Nathan <barryn@pobox.com>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Antigravity:gemini-3.5-flash
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Yes, this worked! To be clear, what I did (and what I'm successfully
> running now) is:
> 
> 1. Start with mainline as of commit 51cb1aa1250c36269474b8b6ca6b6319e170f5a5
> 2. Then revert a98518e72439fd42cbfe641c2896543cb088e3d1
>    ("Input: rmi4 - fix register descriptor address calculation")
> 3. Then apply the new patch
>    ("Input: rmi4 - tolerate short register descriptor structure")
> 
> If there's anything else I need to test or anything else you want me
> to try, please let me know. Thank you!

No, this is it. I will apply this to my tree and send it on to Linus.

Thanks.

-- 
Dmitry
