Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75523332638
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663549; cv=none; b=GZ5mKLOc5ajTdyqsNIlwKSAiEjkrbU3e9tYICqmRZpC+fgkL9YJD5xAUBky5cNeLGQLdWwhc0vFPKqzvaaxKeYmVyDKegyc/xHq6ea4QKlqik9I5YV0DooYYI+lhLLRaKD6Avx7njJe2TylcRSuv2FtJxZxT2EL+a8qPREeeJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663549; c=relaxed/simple;
	bh=Px5HaiRLFHtGk9GEgSeiRjA4kI4KfbcMyMMT/utFXMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdSHE5bPUwD6r82+PcJtYZm8CEmSBh7syCYIrD2y34+ZxlHq6ZdpyF5GOOXbpJToy78MwQ1IoUs9Y+mUg00OpNvn41z5r3uRoh92uXiuVTk5f0u3rOA/8MhWfGiPF5Pu2RWa3UeIhjgRZx3v06Y29x2VUlSfDX2CpSj/JEkvxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A5icUvDl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5icUvDl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1600d040e4so122675566b.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787663542; x=1788268342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=A5icUvDl8cVYbS3wB9rMX+oQXhVYYi6D/clcs6h9sVqO9VnBqgeOoMft8E3M0cpbu3
         sigIo34DNkQ9l0TdGVwG6H+iv4Mk4SFIqc3O5p84iIXdobF0Pt7MUKIIOEXzTwKOWlcp
         ygcKredpDhPdnDZOShBDiGNUO7IVvATmQ44J3gBOb62eSZtXyZ2ajAKln0y20Hl6gyOw
         wDWaWM3kVh8djP6VLG/TD2W+CYGRWAk/4fak7v3QK0TE7p5oTqho/F0BI8bs7eFtAB7z
         Kavzv0RXvYaLMaDm0uxk5PiAnYrRPVxYWWgh3qcBj1jTFWtmt6fqbxwyZkvvuHxE0BUe
         k8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663542; x=1788268342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=A8sMxx6+iLHmvbWJAWkBJPqDOhMRxfwYjts8Tr1eMny6Y+liYZdByUbzoqwoRY0SjH
         Gyuyh3pqSH06dcuIgBEfZMK/5SclGrrfUfIS52ssslH1iT5MwJHPCAVWsb3rM1z7bfsf
         LzZ3O1BwFVBLZHjgRWLaoAs0BpiG5oVFnGMcu8Gi8asbn+ES+zhjIkc6FE02Jevnd7sD
         pTHVcmsnZDI8Snr85jFwwKJtKSOiunDqkSb0TlKPG2xxO+BcCOH9SGEzCdnSU1MslAL5
         vdI1Ki7V0BFofsZfg4mXvketb+hDwUwPUqq52QmfJPmb9TzF2d5jOiDeazOk1XM4wxJg
         yDOg==
X-Forwarded-Encrypted: i=1; AHgh+Rqm/xAZp63ef82UIaAovIvxhHKQEpk1M2vGPiULYcFGlS/5hKppk6ne4tmQd4NF3ipAGSeVM08=@vger.kernel.org
X-Gm-Message-State: AFuF++mfsyUK4Trw8IkQBIMtznJFEbznGBm7GL+EEmGfkBew2R5d7hGa
	dZHyorTdTaQKzxCP/y5vz9U1ngDA/3ENScNePeRjxwRtYJDqjt8uCeva0c9W5+AL4Qc=
X-Gm-Gg: AR+sD10Q5GCOvSyygLKGg2Sg50JcwoDnqmAl0dqUEJAOKal+Ro1D7+TBhsH1EGuMz2e
	6acQ7bWoJsJAyZunCfFEe91k754rIIVoqVTeUKeoED72xC2u0cRRFt8GZNsulUXZ9WNoOINWlec
	lxSN4I2XxbDk+ASxYN957J4SglHqLftj2t+zhaS6Lfyc8oHg3Lg3p+8XIBswrCSchFYsuc1BJ0j
	uYe2KcHJ3AnW3hdD5wMddxaflhHFNlMIzlt7DOLTHEValseLaigqEsgaq7vbG6epYjCJQnb2TYu
	cXvzYTE+M2l9tMIEznKXiqchfwh6azuYfVejt1KLp4O8VYFksnPlXOqulhNKhf3UuU3epM6xj2I
	mCLb+qCV+BFg3NW3L9huN+IM2tzrVB34Q9HkvjEkNfQQqaorD333mkUNgdzO4jOJvEpvUU9woOy
	O25NH1PhsJp6+nKWlMXXzBAoyk0kM9CKf30VDR22sPqRE/APEv0TkURdlI//BKqJMMInlqZFjZ
X-Received: by 2002:a17:906:5147:20b0:c25:58e:8d64 with SMTP id a640c23a62f3a-c25058e9f37mr109537166b.12.1787663542583;
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496866c4csm1922258666b.54.2026.08.25.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:12:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
	jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <ao2UtL6-HHTZ6trp@pathway.suse.cz>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>

On Thu 2026-08-06 11:30:00, Andrey Grodzovsky wrote:
> kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
> knob, so the old disable/reload flow no longer applies there. Probe
> for this with ftrace_disable_supported() and keep the full original
> scenario (disable, fail to load a livepatch, re-enable, load, confirm
> disable is refused while loaded) on kernels where it still works;
> otherwise just confirm the write is refused.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

It seems that this has already reached mainline.
Anyway, for record, it looks good and seems to work as expected:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
