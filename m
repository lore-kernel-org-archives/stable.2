Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AA490BF4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372481; cv=pass; b=SQsc+Fr8Pgas4wMU3huyqOBGgKne8Db5Sy9lQH6m014BzWzPpNZjJiMamhxmZcf9EBlWYX6MQ70iAkHTtLMwqrXuAp+0KbUFCgGVYZMGomJJLK9u2Knn2KHLu9hmBra1W9JnniT4aWiA4kGr2YxByJUiMRZF+Dt5OibO8DOvY2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372481; c=relaxed/simple;
	bh=FpzJ35zvhmqOa2+RwZnppUz698uzzC9G/FlxDAwKxyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfFbkYeHlkxhEYICZV8VNBntS0B6ohBp5bZwwiVNQZLDvCa8YHKii8UwxSaxWXMs07OSzEacG+ok7i9J/y1QjCxB/CuiGbnyz2bEAOIZKya85Ffx2rggK1cuzi20zsldIp4gflSVBhvNg/Mj8CL7nWALfPwfsUYLqYFYCN3531E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekAsJW71; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekAsJW71"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ae8607e8afso18576067b3.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 04:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791372465; cv=none;
        d=google.com; s=arc-20260327;
        b=Rw0OLQ8PCTj5MQOUIdmyJYBxb3g84yobEdZo8+gmdvSctG3rQNrGDOa6xyFd92+j9V
         b3ys+RTwGQFoyD0dzlzGQT2l3EXl9BP5uYyrzEyWGNcBblx+/IKeDIQa770/kj8hVRkC
         8RRw9p/8lpM6ZSH4b3Gzb5EKfFs8Br3wvXviB/OgHdaNGXpdrwF2E7jAMe4+m300KFH8
         cBZV6UicXlxn5snI2qUOEx4U/V6izWJRqp5bfw5Yj0cPn9Qa+pMzL7OLj8WnuMuQRNk1
         BqdItAiIntBe+VqFj/xjHSR6xD6v4wE6/7YP6r7wA9hqkBXnw/l12lGyDGZSWbdEIWbu
         k8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pavyWN5UuE9jlfBpdpJeca0fIeVjQP6tBMNr3yh5OZo=;
        fh=Hkmw25078/6+im8VkYpks7cDVrfCdkUY+iu7+3p+gIg=;
        b=dPRKp+xSXkFkdTGOUyoDC86/SY1MMaRNwNCEMAU6x7TNSLSDG2Th+4Jn6y8wLdMJX7
         ZKE5X45tiy8MnIpXwRMmszo4Mzrcw36KsX7kDj/YbhjJgIE9VoFYQvFHugqzH8EP97DX
         gsLonZtyGutcVFWlINJv1VXPo9ld6jr94nl8G1xByfsEw9qbrhzqVq9gxhMZ9RWMXLGo
         EtMjjN7GPlH8QChCL8qfly+1o4jgzrmA9v+gAHM+cHIRKBEbBn9GItcOjIt1vnneybhF
         jtMcZPWqL/OlMx7W14dBdl/UIDeg7FKpCbjUamrHkiVWe7Ed1ynA2k+7ReZnFFqa0NSC
         5yQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791372465; x=1791977265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pavyWN5UuE9jlfBpdpJeca0fIeVjQP6tBMNr3yh5OZo=;
        b=ekAsJW71M9T9SI/egh4sshHwR7cszL3UPcuQljDyCjPu7KzXjwEDvTaRBqszr9jTbp
         o16EnFaWwL7HV3TI2cvXq7So3tpp9Vblj+zpY5YaunZJfBSjceaGGNndi6DY/10ernu6
         Cf0dY6kF02KBthwTwnnx2Cxldp+xxDfh/XYHptxyic7YhVr0tJyT1chQXp02h8jCwZEA
         j7g+h5Gu/jKROvgVOOqWTNcmakOKkgi9JkFpsY3vvlVfmNklHhnI5LApP4O6CsxEgxCK
         wk3Fpx9r2fZhJdCW3ZTZfPt9YpU4hlZ6lRJTswEUl0l79xfQdsIYIOxHiK/+3z4o3mn2
         CSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372465; x=1791977265;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pavyWN5UuE9jlfBpdpJeca0fIeVjQP6tBMNr3yh5OZo=;
        b=KI0i6yWR0gbJTbBERQtUNA7L7oTXM8MWdcb99AVmvLi7RJcHdjfQNTdERD0lIY/aM9
         lSzkEwSrMk9VfaEBdclrmh6ztowtkk1tyv4u5H8bLh1LAhqcZPVQEg27c44BZTaIMI4F
         icyKzHlqW7n0ZBTH5v6OO1bM0vDgGE4Sb0hIK93lVwJ/Pk2V4GeSOo3WM2SpZI+v3ln0
         Flhiqh4ATM57ayRrjh9LTwz5rQfegnqAPU1s3+qcBcYxZdMQ8+QIUl4YuRKzAsVVsKpL
         34/gg1iKNHsCh3qGGs0+utHIKJJJzulxBgLn8OWxjtoUf3BuNbx/ZJSDHAZqYomo43zC
         Wb8g==
X-Forwarded-Encrypted: i=1; AKwUvBwIK9t+/Q6whrDYskAAMcK0mziCVDdLohfXWdNWlgl+qMteErSFlK9Fe8yYm5J6e5F3OeI7C+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgjUuPNrMbmX5m1dE87EkZ17cYESkLfGGHhOE46lRQGXHoWFzN
	v0wWnwqysLorhWly6cGnU7bs22I2/lXcrvfXNLow7KRxl93NZulmgsgRjtaOSU1fhVronygVdMr
	e0bTa8jDen00gnh3f+OKhUNlvVUxBrgE=
X-Gm-Gg: AYBFou2osNW4SFX3kch/ErEAqahOkC7P6mtN9KgkKzkJxE4kOZbyDAa5MLpQWwT2u7o
	b+GJ9fQnyB5OHoVKmNJjdUFE1dSzvRpF8HKIiG4b6UhJ6mVaE2x7aHb9eMhkPAz0a1ejhGTM+lj
	fqoWzPDRL6P3aYS7rgvNP+9Bx/U3yuGvDp24hnRgOwR4IeM5/2yRn3uIYF9othtCwjv9loT9gAa
	GeJg6hbYivc8C2Y3WyNFzOELFSEOlG7aqpidm2Kz1NSP9yuhy20AP4BV6E+cpGitJXs7qApfWVA
	AQd3ZTtUqacgmsXhwcFtWFe4hXE34okJ8CsrQaZvqAFXcmZp84D73E6oS1EvmlnzdoQ=
X-Received: by 2002:a05:690e:1182:b0:675:6d8c:f445 with SMTP id
 956f58d0204a3-6790a0b3142mr964922d50.10.1791372465276; Wed, 07 Oct 2026
 04:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808112043.2781244-1-lgs201920130244@gmail.com> <ar1yiPC1pxx8H974@lizhi-Precision-Tower-5810>
In-Reply-To: <ar1yiPC1pxx8H974@lizhi-Precision-Tower-5810>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 7 Oct 2026 19:27:34 +0800
X-Gm-Features: AclHuK9xkPJNTgSq7-x7dqK0gz-t6G-LeWcqzQTZVQ2BJAwWf9PL48vGNZtximY
Message-ID: <CANUHTR_w4cOAOoYDCDS8bwzPEuYgWp1KjZztgLx-4P1kkhwjiA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom: hidma_mgmt: fix autosuspend cleanup on
 probe failure
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Frank,

Thanks for the review.

On Thu, 1 Oct 2026 at 04:35, Frank Li <Frank.li@oss.nxp.com> wrote:
>
> On Sat, Aug 08, 2026 at 07:20:43PM +0800, Guangshuo Li wrote:
> > hidma_mgmt_probe() calls pm_runtime_use_autosuspend(), but its failure
> > path does not call the matching pm_runtime_dont_use_autosuspend()
> > before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during cleanup, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the probe
> > failure path before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
>
> Your descripption doesn't match your patch. You change change pm_runtime_enable()
> to devm_pm_runtime_enable()
>
> Frank
>
> >
> > Fixes: 7f8f209fd6e0 ("dmaengine: add Qualcomm Technologies HIDMA management driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/dma/qcom/hidma_mgmt.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> > index 4805ce390ffa..470c88f36d25 100644
> > --- a/drivers/dma/qcom/hidma_mgmt.c
> > +++ b/drivers/dma/qcom/hidma_mgmt.c
> > @@ -168,7 +168,11 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
> >       pm_runtime_set_autosuspend_delay(&pdev->dev, HIDMA_AUTOSUSPEND_TIMEOUT);
> >       pm_runtime_use_autosuspend(&pdev->dev);
> >       pm_runtime_set_active(&pdev->dev);
> > -     pm_runtime_enable(&pdev->dev);
> > +
> > +     rc = devm_pm_runtime_enable(&pdev->dev);
> > +     if (rc)
> > +             return rc;
> > +
> >       pm_runtime_get_sync(&pdev->dev);
> >
> >       virtaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> > @@ -310,7 +314,6 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
> >       return 0;
> >  out:
> >       pm_runtime_put_sync_suspend(&pdev->dev);
> > -     pm_runtime_disable(&pdev->dev);
> >       return rc;
> >  }
> >
> > --
> > 2.43.0
> >

You are right, the description of the patch does not match the actual
change. This was my mistake.

The patch tried to address the missing autosuspend cleanup, but
instead of adding the explicit pm_runtime_dont_use_autosuspend() call
in the error path, it switched to devm_pm_runtime_enable(). This made
the implementation and the commit message inconsistent.

I will prepare and send a v2 patch with the fix matching the description.

Thanks again for catching this.

Best regards,
Guangshuo
