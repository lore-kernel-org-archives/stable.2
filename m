Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3B3B637C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431576; cv=none; b=bmdhAqY9glA1CAm9A0I5Pb8Ovb6O+siZHVDJSRX4ZTH8Gh5eDFoWJ/QM4gup/W5F5xPNZhykR7beDLsgrgx94kUa2GUbfJB+HzJv9ChLxuOyXNRXr5J4y8hWJUezrjDnMkBqEVZbqN+V8AftDT5sYIPntbhS2ncv7TUgwrb7tvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431576; c=relaxed/simple;
	bh=09F84nm6VrA788U3J3dKsoVjl0CHbnYuxWMbxBF1wG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0PW/qppN+NpP9q8MS9om3rBmPImlV3nzYO8y4Xrw/gct1CHA5a8GGAPiAPY7pJ1yQr+FNSRqFZCpI4bnVc9G+WB9dWgazYvXUovrpjvSNAQO1XsIIRkQx4cWN2Rl4QzsHfzysFICz8xF6/X9fWe5iRhxxm+3AAfma3tFKxx2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAf8PIMO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAf8PIMO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fd4531020so1664657f8f.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786431573; x=1787036373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7CGZZWuF5gk+XdnSsb1yoIVgT0uOaJBdpMM5wtHERfw=;
        b=ZAf8PIMOoNhe6OGENMzjZ6QHaPGgXEo4vO6eZLxIxOsK/g3rom72JcTNpZoTSEHGKB
         6bw0N9UTGcLoUpy+hoOTSpXWrPkZBOFAtPGRmJI+pG2JMs1aeHIP6Y3p2qTfHEQFv8BP
         DyVpoX633cr4z92ESwrxO9xqpkJKSiiX/OOvEPuFN8oZvXaj1CV97WKTlZ6gBJybPw/t
         D5q/+1c7p8kPIn6xAOfyIHH+0G+uEQopNHQWrnl5pTKDdLnfYY4bvGHFUVi9+/HtXhB/
         RfkVI/z4pqMmpmH9Jdfbiai+vOy1Ell6/B/NaNSoLr6R5m1fmuRwTnhqnYr3KTazvBIC
         P7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786431573; x=1787036373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CGZZWuF5gk+XdnSsb1yoIVgT0uOaJBdpMM5wtHERfw=;
        b=BjscbLv2MUD0+An6OUHSPdf0RONzZGqtcWJcjLpI9zKMr50DM16AYgavBxql501e3Z
         0ippoATue7hLGay90uE0VuqGwpCbcL7Q6u1Z/rcTEcfGVk16Kd3TCqpIEbJd3BdaFQ8c
         jD3jtD95dpjuUaRIu00Y+zhjeiUMn1J6vRKKO0kg6dgClLgI23Bvs7bKR+AeCWzMChsr
         k0+9MWgUV9YnCUwA306HLme2rdLJQCyKSryOsfoUqJxqVIv3ePWZJOqoCmKkXesPflp0
         FZYOcQfypZhLI9hQjNMuC+4vb2DhfkOhIHWaa4hMl9QPhZzn9x3wcrSzqvrUTo3nc3B4
         4xNw==
X-Forwarded-Encrypted: i=1; AHgh+RolUi/kQYLBG4i0dqsfBJKurt3rE4f6fxwnkJZPzI2QPbRVeRkZyPBjluLRgvchAsPofF31bOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUVQO1AOHDaYPC2AlL1pCmkabwdqkKslFIrTJxNDYIDCex+xV
	3xC/RfNhyKQx/MUoMhFcMlPqWnju3ZKLYajBWtg1rkUU8d0P6GiKTr3U
X-Gm-Gg: AR+sD10PeTqrM9olLiAvfWqSSrdEV7+//tMR5rtOluI8q1STRus8FMeLI9GebtHIETr
	yMKPmlurJl3nRx19EsyZHGzCiJQBIM8RhuYd8uhUY7GCpseHeRw3YHw8p5X9QWpyh0fhzQowDsd
	i2qWpEdKAQdx7VljUN5LyFhO4k7Rw0clA7Ako3YLElz7xrEDwiqkGTl0F8lTGb6gfLiP4sPRqvs
	vS17UG1GLuOAe47xBVp2Lk9hNxD2CD5sfDeW6uQ3fnHK7aEy2dJSHvu2jVBMAMufcTToR0ZRgK0
	xG/wKlPfI5S1K7eddsqFsKWbW/TMWe61AKKXby+mYAoz8AnMceaSdWbFllldjXffhNYVmXG3wlM
	27ZQOZMVue0kDAGtMdtPAKf9G3zsU5ZkVaCUJwt9WOmM5PIKQcAHnGaC+XWIyZoiTn5aGAkxMqY
	hSybOt1D4b2hwGrfsmqD+2zc4BHkS8Fzty7G+ZnWc/jR5/mDBvjPauLMZfAskTnj9c7KGAOHkOz
	HQdsdt5WE7HZt9ZPsdUzHuwm55Wi1DZWJaQudLxH+ZlBeOj6VLqhyFlZ8f47Ka2cppEvvoJKK6o
	jxMs/LMkw3jbgtuX4K/o9/tdGQtXf7RUOqR8erL8o0kI03XC1yWRF7mpFBPC2jatOF7fJ9w=
X-Received: by 2002:a05:6000:25e8:b0:47f:91e3:3cbf with SMTP id ffacd0b85a97d-4814adb1f0dmr1920243f8f.19.1786431572901;
        Mon, 10 Aug 2026 23:59:32 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cdb8sm1789573f8f.35.2026.08.10.23.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:59:32 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:59:30 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andy Chiu <tchiu@tenstorrent.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Greentime Hu <greentime.hu@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: vector: preserve state when scheduling at nonzero
 depth
Message-ID: <anrGG3id1adQLGED@gmail.com>
References: <20260806193241.10552-1-kmehltretter@gmail.com>
 <anqv2bWIvgIyhGxe@Tao-Chiu's-Mac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anqv2bWIvgIyhGxe@Tao-Chiu's-Mac>

On Tue, Aug 11, 2026 at 01:15:05PM +0100, Andy Chiu wrote:
> 
> Since the problem only appears in the v4 series of the kvm fix,
> triggering this bug on the current upstream may indicate that there are
> some unclosed path that leads to the error. So it would be valuable if
> you could provide the exact reproducer and base for us to investagate.

Hi Andy,

I first saw the warning during a syzkaller run while testing my KCOV
series [1]. The exact test branch is:

  https://github.com/kmehltretter82/linux/tree/kcov-pause-v2

The following branch is based on clean v7.2-rc6. It has the stress source,
syzkaller config/log, and warning report:

  https://github.com/kmehltretter82/linux/tree/riscv-vector-warning-repro

The warning also happens on clean v7.2-rc6, so KCOV is not needed. I don't
know if KCOV changes how often it happens.

The syzkaller job had reproduce=false, so it did not save a minimized
program or C reproducer. It got the warning after about 110k executions
(116236 at the end of that cycle), with QEMU 2 CPUs and procs=4.

On clean v7.2-rc6 (b9b3e33b70b7), the standalone stress test got 18
warnings with -smp 1 -icount shift=7. At normal TCG timing it got none. I
did not see data corruption; all byte tests completed without mismatches.

Your v5 patch 1 looks better for the switch-out change. Please consider my
posted patch withdrawn. I am testing v5 with the same stress and syzkaller
setups now.

I also tried this possible switch-in guard. It got zero warnings in two
stress runs, I am still testing it:

@@ -392,6 +392,7 @@ static inline void __switch_to_vector(struct task_struct *prev,
			next->thread.riscv_v_flags &= ~RISCV_PREEMPT_V_IN_SCHEDULE;
			riscv_v_enable();
		} else {
+			riscv_v_disable();
			riscv_preempt_v_set_restore(next);
		}
	} else {


[1] The KCOV pause series is five patches on v7.2-rc5:
    https://lore.kernel.org/r/20260724192122.73080-1-kmehltretter@gmail.com/

Thanks,
Karl
