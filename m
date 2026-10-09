Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CA4A32
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791504649; cv=none; b=WVYpsALWqpHSlSiHvFJQejXUMSWhhZasloU/DC9QJjkGjuT4+d9608cS7+ICr/cLMf5xMEleCMR8CVv2heMUwVvjjy8pO6jKjXibQnj9zewi0pd0spdn/FIx0FHoB9Gs5LklzIQ1nlLp9EKy5vvUDqpP/ulHKUYMztJ2mJwJ7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791504649; c=relaxed/simple;
	bh=tqM63ocasLYSxyrsrCYjcg0TnQLEfHkogfNcM0tJh7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgwI8PGAtIZ8JuvFDqRTVJGPr9Nm04bSiYKFv5UBURvR9liAvLA72jZKbVKxGCM0IcIL3sbzV2OlKW0yypPqo8ttMKfDNMYszu4ZNAdANjCtRNpqBsCerx64M8Qg2nrBh5CBL9n6NwlthIV6zI0hKy75J44PKz8DPaq3OxUdlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/aP2ImA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/aP2ImA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so32198895e9.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791504646; x=1792109446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+X0gO+ixBDj3LcebqVHrpa9pmpito3V5BFoUmFDMA4=;
        b=N/aP2ImAB5Fr+EUYcC19c6Tv5zXITWtpR6KphsDJ5j1/GGbYBOJUhA6lsVAATuCmO8
         3x+x/gKAKjM/0FIyLxKCMZKQE6H64IG0lOx2/5wUKRlz5ulsPQniix64bDXf9CoJOSDF
         sxuw//mKdsuNzZv05qaIzZjqqVB3bm68RFaQ0RebNotcyJTyPslE3+VoCQI+3SxpgIuF
         h8yk2DlLecxxYXHOYejBs3lH4uLMyDUh7PBVs+FibS8sA1Ck61GSuky5FczLn+8kBpXE
         ApxKbivLUKa+zlTR9jllp5C0uJcuMPREhQhDal9DBOUJDvhLBIYW4y8prgQ1F3eWEGkX
         HVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791504646; x=1792109446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+X0gO+ixBDj3LcebqVHrpa9pmpito3V5BFoUmFDMA4=;
        b=kWce0cYHZASNs+or0hlr5LBHsqfoqhSNrsNNZkROIchNkqETKJ8Lt4+dC78RkpB1fO
         s4xTK1+bSGhAnRBLcgAzoUn19piq1FjwXziBwWn8uCMWOSg+UEGlW7iOIqEbJQmzLJEM
         jq2JN02GRInnK59n62+M6ZwF38H/TXXz2cgGKwC3OdPdAoUj64EwkBnN/McP6fe7lmsi
         6FVf2xJSC3Yq7y4dIfscmfbVFAtxmXimP6bUXOXzhamvfUR6d/y0ZBBU6UP33inq7wNf
         Va/VMNCOdLo1lewkUOOmyYEO1lApmWAZao3i0NLtqyqh2+X4TmT2qlGnN47beEC2JaPS
         fNag==
X-Forwarded-Encrypted: i=1; AKwUvBycSbPe9OJm+d+8U34i4TTUDTYSp567odR0SAeasjJSgY6YoRvcNqbuGw+5/qkf/ck7EQ2zfW4=@vger.kernel.org
X-Gm-Message-State: AFuF++l43NmG2qoZm2i9oBPIH6iWWTjd2/Bfb/L+oTgLu4tSG84JtDkv
	IaNfvEUAqxIEQjsfXwxTxAaKVPKdDnM48g1a4C6yBbNrEn0kKRyqnXOG
X-Gm-Gg: AYBFou2JRLyq7fjcl324onk0NFgMKVwOndO0/kffupkhe0o40C53PtvizZI6q7yCU+7
	+InfdxWrgi/9OO446sHjz0O5vwAAepUx+4lEdl0Wx3WbSa+jyDQQsvID+V/+tUgUrfSvoKJlA0P
	HiqRW2lr4ZA850iqEjZgRWoQrarNQXmn1038mghRn6gseRMP1eHhQG/J969B1QALVuRJOJIhRpj
	ysyDQpvsJtQdUrPS3YJ5el2qCqpnWAoHuATnQslyB8W6yC5byisXWUOAEcIMqZJeRfMkiEQG3Hf
	4eeZkEvG/Iue88AAz8t99+dKtD0kATIOv0okajEKo+TK5ML0A6/aU2lCrZkvYWhqSXtzo9QlcGl
	WN7BSPOzyCZaBDuXSKD1HQDXePFkwb9JFNMAyDIWSVGopNUJDDW/tseLviMWav+dF65pkk6AwGT
	bf8f3IHPNFZ6lDiDF+WG+ibRZPMN8glPiUfvALS8KUXHc+wp5S2DpmK9qngNWLN3RuKZUZ
X-Received: by 2002:a05:600c:3488:b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a18e4c05d9mr1979015e9.21.1791504645836;
        Thu, 08 Oct 2026 17:10:45 -0700 (PDT)
Received: from arch.local ([197.207.161.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm27959135e9.8.2026.10.08.17.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 17:10:43 -0700 (PDT)
From: Akram Boulahia <akram02st@gmail.com>
To: mario.limonciello@amd.com
Cc: akram02st@gmail.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	scardracs@disroot.org,
	stable@vger.kernel.org,
	viresh.kumar@linaro.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Don't fail active mode init on read-only auto_sel
Date: Fri,  9 Oct 2026 01:10:22 +0100
Message-ID: <20261009001022.6660-1-akram02st@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <851316da-2cfa-4a22-947c-1838532d05cf@amd.com>
References: <851316da-2cfa-4a22-947c-1838532d05cf@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 8, 2026 at 10:12 PM Mario Limonciello wrote:
> You're in a really weird path if you have an 8945HS that is using
> shared memory.  That system has MSR access.
>
> IE this sounds like a severe BIOS bug.  Let's see what happens after
> you update BIOS.  If it's still failing please share an acpidump
> somewhere (like a kernel bugzilla).
>
> Need to make sure we understand why your system is behaving this way
> before making code changes.

Thanks, you were right. After updating the BIOS from 308 to 311,
amd-pstate works on this GA403UV with an unpatched 7.2.8 kernel. Active
mode loads as amd-pstate-epp, amd_pstate=passive loads as amd-pstate,
and the "CPPC feature is supported but currently disabled by the BIOS"
line is gone.

So the BIOS update was the real fix, and this patch only worked around
the old BIOS state. It also doesn't handle passive mode properly. Please
drop it.
