Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DD443C2A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125659; cv=pass; b=ZDSUOoR5cit1mxGlr3pXThMrvF1SxGpG3UzkCIjRjn1KPx23rDW2EBlJ8ye06TF7NqE7d38mhcQcWIp4UprL0xtjbopJU3eQa96R7J3HQvhi72D4fZ9P0Xt18BK6ebl9UgA2mAWGjNhi1IfkMDafsg9CQEkUZ7fKfuGhGi9rteM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125659; c=relaxed/simple;
	bh=Fds8sz2PUdfOGmt3Fzs5pG1hKhISPGFhPz7NxEHwyVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qqoIHwrtCCanXUlh6jBZeoKHezAnnzNEH6kVEcBISdQloXq8IOk4SYkCA20pwwalMUiUjPU3dyzBbHowJprfJ64Y7k5orBmY6/hpn2oVChFQe+OXoI2kK2shmK6RUmanxSsUAZy6NVj0jLKRPe3Y7jcBFVkdSZ9mW3oXrEp3bQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=d50jaqvG; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="d50jaqvG"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-47bad4566d5so366364fac.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 04:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789125654; cv=none;
        d=google.com; s=arc-20260327;
        b=ADZtJozqJraO+ggYqSi0+BvjOIZO2/tOEaB2HHISGibdPP3joyrrFbXeIlhRy1XFrz
         YYBn/MHiuNF0O36S61pIK8DKayO8GrCRI6efxr5OYbTwrmgatHBfHIHueZmtSTwdb/t+
         yOa3ftt0Xan5P2x6UeMGOFe3Atc7QUhLFuh5YSo3+iYNuDR73GLsfvi/0x1xY5d1Mmk2
         /OkFC3WVowla29eotteYZTkFELnIAeygjDWn4E/ff+r8EtwrSV0QCQSCxaQpUUg2n0uV
         70uiaivcPF/6odIN8W6NtCPZHQC2EzDhkGAWnTpSf2/tx9TsPPUh1ga3heYmHufw654T
         B6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Fds8sz2PUdfOGmt3Fzs5pG1hKhISPGFhPz7NxEHwyVU=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=dRERK1ukcmOOmyVhaofad6fjmr2uMigCW9V3387l5i2M3dk2/XgoGWXL334f50awv1
         BP6utcAlIaAzNzez29NNcMHfjwnSXKuxoKuz6R15aGZ9mm/d5eBJR1Ktx7cYDfqT8gIQ
         w5bBY5mv5wm+4n5/N2dEZCGjwMe4j4uM0GbjWkLkLNffCzeKsXyqwYohz7+oQCd8o8AQ
         gdRqfKp+0ckBBvolDSa28ecVzuBBjvHo4ymGHlu34TykTx7WF8betle3YfhZzm0ALh4s
         0LKzCvMjgL2TRYnXh5ozrStLXPeDDf63f+4A4X8DRvAm6itznW0sdAcYYq2y7DqOGjXM
         agSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1789125654; x=1789730454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fds8sz2PUdfOGmt3Fzs5pG1hKhISPGFhPz7NxEHwyVU=;
        b=d50jaqvGGUj0wdaFPA3OAbsWKhuDaev5v1UPfNzsoGZ5cMCBnRnhqAgPV2HsL37a2p
         ZpxwbEkVWWRJI+5NiNoiVUJZdhyOSU8n4wTbQ1nSdJBOPnKk/rP2PZXxg3gn1Q5JRY8d
         fcQDo3oWESc5buQQk/RQsZ4OPY0f0Lwb1nqjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125654; x=1789730454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fds8sz2PUdfOGmt3Fzs5pG1hKhISPGFhPz7NxEHwyVU=;
        b=Yy4DFfgTkE5KrhpeAOqS1xZ/bUR5HqcwJ2osLPJNv2izbYI8W3hBoCXJcDAfBMpBqA
         sBsKv9C84vS3jrVoxxJ7wAxCtpRr7WE/t3+qtkLwfMxT2C8zLdpedXrpHrrlzNWUn0Zk
         xggLGMAE4wqGqM3z4rHMzaJo0SrFW6e0u5wvGTf2ma8KKKNIFkOA2idqW/HIobxQ1H/4
         LJduk6o1cTOMIlsPUzk94WJNsnwVkS4S0/iwSCl++359FkOWAHDzab38PgoUuzxlakt0
         pvzn5yXlWrX7r6vB2QK1k5KWAEq6Rx2MtoMo59pKXBxmJR/PRLGBKs5+eljV+A1yMFF2
         gjsg==
X-Gm-Message-State: AFuF++lqruQy0SPlhLtCuO3fwhOQh73TU6DamcTKstDeDtorDpgODRPm
	HmYnoF85QkS9kcwL/eNCzLzpOjkfJCxfGMQxnw1k14XyWfZLcctq4AUNLg/NLE4vgUpklMVEkg1
	eoyKGPMHECdWnXP+K6cTg9Ya4XyXE3RE7acO2JmNd0773wwLl80e/Vno0cQ==
X-Gm-Gg: AYBFou3dVruHl4oK1HRRG7RFweXWtbYSuS+tay8fOshZrJlgxopi3Ic+dYyj6H/Mx21
	sXp48WSKK9jbNxmHlCNx7CCqteNmW4KMfA+bb1UyZZ+bvDH0gDaoVk1M/WsuL+z4QNe3ZuUdpn7
	b1m+VAHtYJpYqndtJ2tYLeSCMn6hx02juqY/5hYOOctSAFUtStkNnC0bwBscRzWpCTt/+AyDGPY
	G1jjlyoMPh/Fv5jb9yPqXKVAM1rt5huY4GqTt1TN3pLfF2FOBvoCL4wIrfQ3ysrD+CLuiK1ROCv
	yepae5UF4W1P6KIlcE4BKrcJVZbfOmiLXYO6hyx8IcRzOzKDacYw3y1ov3k0940B+j6CfqeCUm/
	ayHMU3iUAgvZjKSV/Dnwe8+XsQE/jqMhcwsj5IQSgUA==
X-Received: by 2002:a05:6870:e0cc:b0:465:8554:94b7 with SMTP id
 586e51a60fabf-47de86e350amr2741757fac.12.1789125653680; Fri, 11 Sep 2026
 04:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hardik Gohil <hgohil@mvista.com>
Date: Fri, 11 Sep 2026 16:50:40 +0530
X-Gm-Features: AcwNN1W3bq8plirK4CTJj2F_hh8nvGjpUVrukam0whmtHtzSbxvOiPkl5vdtVbs
Message-ID: <CAH+zgeGSQTgn=LVUKj-T4LnxSFjn-t7cftfAiEvAsQpdr9sfXg@mail.gmail.com>
Subject: Attaching CVE-ID to specific kernel fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Greg,

I had a query regarding CVE fixes for LTS kernels. I noticed that
while fixes are backported to LTS kernels, the corresponding CVE ID is
sometimes not included in the patch.

May I know the reason for not adding the CVE ID to these fixes?
Wouldn=E2=80=99t it be a good practice to include the CVE ID in the patch, =
as
it would make it easier to identify and track the security fixes?

Any views on this from the community?

Regards,
Hardik
