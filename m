Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C573630AC
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931943; cv=none; b=q6Y+Fi+oVoj+4HkSliAKiyiFf4naP3uX6yRRRS8kKyVaYfzkaSHfym/Nz7vgoqzN5ni6K1NDQwogKOLNboDXyf+4XM5rfaZFfnTR8t9VkOmkITv0VEOl0VbK31KI+JV+M0j1k49OB6js/dEnALXKvEYcOqeBAZ5pRBmgNWT/WTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931943; c=relaxed/simple;
	bh=iqHyPDmbEI5UjvdpwHm556L6FUL7rp1Tr1ANQ5JF3l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg+b4+7c7RPby9F9lXJs0gAzMTHjJf58ERb6AYcAZDei0r57+gMr5DoMz5lVkVtLiBjdNBSxod+FTRB8cz0bhNiMAwTSSvnr5bHgWhO2dNBboeYL4ZmFINqfLXZlW/P6wlygbk2dAD+ZIUPNjJA4fT1tCoND8zBbL5cn65I4nSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8yWvu1L; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8yWvu1L"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b9320423cso9826985e9.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787931940; x=1788536740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wQSUgBrIOZcFCsKuEyQcJFeC5/K07XFbazjqe2DjoiM=;
        b=J8yWvu1LM69htdEm1qejlKf0cAFLXtLsEq+3sGKc23UDan7h0ky3lvfYnc6LqKnoIy
         QMH4UGxqrfLvK18o6XkpfhdNIrA0RLHPDpa3jVu2WLzVzzwXqAvQLNU5Lu2miJv5IP+E
         NkM30Dj/bU27mMDrRXHvIj333N6PlmWKjms53JHERZG5jY7Hwk711m7J1eYFdoikf8Kz
         23S5O49pupYX6w+YFJGIasCCf8r5TQPE1gXL9VwYy03BtZ1QT0EN5LlcKEbatgmUQM+x
         n8jyRcyYUvqbnMBLFwugJjIXu32KubrAwDzhG/zfhC0z+GsyZhH37Buv+j3kGzIat5PA
         RioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931940; x=1788536740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wQSUgBrIOZcFCsKuEyQcJFeC5/K07XFbazjqe2DjoiM=;
        b=Qx+au6ZXZErQOkkbv09FCJFzCeHkodGnlQhfj7OWNLzRVnDGi6scxFxw8JhgP5NLEx
         YNLyk9IZdAinWM4iiStdHPqZdhzfXQuEMJg6waaSoeZ4KG1k8SJx/MFGtGt6M3L2FdB3
         iy4B2W447C1uRYGLHMLu4gynfspBiyl9O8GH0Oxmx5m2iBCEC3/zMULHJ9J/exGTouAH
         RxneAA5JrWNBkcE6+GFyy7zqOdtYck0CQeagx3BIWU3tung1Catoq5MByuxY5PxTX2jF
         4pe+YY6D0zpbnOtAtBH06UXONFtkMoHgwjUUmep5HVhayBa7WYsaymsrDkAJKrghXKNy
         gYnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLnFuRlWHAoxmFsV+KvoZ/VnlvkOIzjaRZQVYwIucYfT8DAyAdoz5lyUW56/Ouu529ynCcKDs=@vger.kernel.org
X-Gm-Message-State: AFuF++lB9ihR0gQ8DsuucLEGf6K6cx63HvYc4zdw7CsqUT4SO5srEmiL
	i6qtTIdLLJiobxwnbK06DTivT3UtkhrR9f4jyeHQyrgkZGlsvNUyp49q9BRPqdxm
X-Gm-Gg: AR+sD13xbJXsjbYYP6/WeKQcY4EL/WlxRAgKqp8QdqvSS5+rgkxUIz7T3svkzGt6Lc+
	SqBF4M+TZ4zf4B+NzF+gjLzEibuCfCdzrnk9/FfZsSoiYDe23K9vrNSJg9mID5zfYsL4mErqC5q
	jHkFodQycZzrhNIgrMS1v3CTd/tF4vZMuSmLgcdO5VYmMDTBTd51eDjoJ9NXFxysHWlCXOsJddt
	tteOo1QszlQPOq0PNSAM2CIBSf7TJFMQPFu0utQXWuAv810l+oNe6jIxtPKXMf4mOH2w2T7x2rK
	qNiy4Hp03A9jvgOF269dzLQeeJ442fDJ78CgTZGJ5UfizmWE3yRb6jWQ2gCkciEEWhW1kzqd9/I
	GS9bQIPMWJCA+Md22ZUUsoBprLIZUEcx0LXsBASlPyafPogpkpOUpLIOkGmDMq6CQs/RnyikrC7
	iOmKCXjzNgTC4FCYORE3ObqoNdU5WjACQOWHKQj45DRG/UGOnL9QqSeOhEtX9bRMk+v6jicK7Ge
	jTA4+vOyKb9/g==
X-Received: by 2002:a05:600d:13:b0:49b:9205:45b3 with SMTP id 5b1f17b1804b1-49b920547fcmr110432865e9.15.1787931940285;
        Fri, 28 Aug 2026 08:45:40 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb34ae6sm5080266f8f.37.2026.08.28.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:45:39 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:45:37 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 2/6] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <20260828.dc270da340a3@gnoack.org>
References: <20260813093157.1436894-1-gnoack@google.com>
 <20260813093157.1436894-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813093157.1436894-3-gnoack@google.com>

On Thu, Aug 13, 2026 at 11:31:53AM +0200, Günther Noack wrote:
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 7ffe2ef127ee..9c1102ebf06e 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -351,6 +351,7 @@ struct landlock_net_port_attr {
>   *   device.
>   * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
>   * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
> + *   This also guards the creation of whiteout objects as used in OverlayFS.

I will send an update to the man page adding this line.

Tracking bug for Landlock man page updates:
https://github.com/landlock-lsm/linux/issues/66

–Günther
