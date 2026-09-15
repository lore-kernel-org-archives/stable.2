Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB24A49B2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484061; cv=none; b=KvptmrBUU3cFOrBo3Nn+L2LsA+5+6qMM1e06L11LnCgVlI1j7kY5JT6q0eaNRelHuneXo40RVlNtsq+9RG3QwU0Fq0AUI5PgFVthHlvh5I0zcgFOgx1d2BWJ8IhfS3UIw5Y+xW97PGo91iV1abf7O9txi/ImSAYBV2vs4gl/Prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484061; c=relaxed/simple;
	bh=Jw47583dEsm0w60VPRs+p/8BYVI0hMDnyfs6cyl9d64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDbUyp/Y9wz5tyImNCvSWj2GnWJ8y1XZPAxrHCnugUfkrI0EGasApFO6G+kw5ghZ5e7tXKg0Nu4Ezs7VL9ee/N9eCZH+MO7afmYdvLL10rGPWyIdLiqb6rdO0dgjq0j26ptuKmSWQpan9pxJ1HRp5X6SR+ltlQPpq0rwGuwYRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=BWj9rCmb; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="BWj9rCmb"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4hklPg4VNlz8JZf;
	Tue, 15 Sep 2026 16:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789483991;
	bh=Jw47583dEsm0w60VPRs+p/8BYVI0hMDnyfs6cyl9d64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BWj9rCmbxZqln/sXScLoJ3/he33GOvTbKK3VGYUdbHgwbe10VDlz/bZCqaWsnAL4r
	 OLzpuoZjwRoEU7uFQ+Jf5Ky+uGuESjMxe6lVANl/JrD40stknjeliashT/uTPNkQxh
	 LH+vBo7FEt9VSWSwoiEApuQIiVl4L3Zaj7VNIPY3AyPPDm7TcMOCFdi9MHGwcvl8t9
	 0nHUGZdzz+NV91lRpWKEar0jokwSx8PsrGVWCQmkeRYlBg/TGYH/gp2Z3SU0rOVPP7
	 S6uGjP6WEN0q4khd17kG94GRvc3dPNm3ajwKD5pTeE9pQTbb4kjH5wZ/WTZvBmC/vn
	 0iD683mDasY2A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4hklMd5YXwz4yV1;
	Tue, 15 Sep 2026 16:51:25 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hklMc3Sd5z8sbC;
	Tue, 15 Sep 2026 16:51:24 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 867DA5F9F3;
	Tue, 15 Sep 2026 16:51:23 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4a76bd61-13a2-4010-81b7-bcea325b9c63@leemhuis.info>
Date: Tue, 15 Sep 2026 16:51:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [regression] 'scsi: core: Register sysfs attributes earlier' in
 5.15.221 broke booting
To: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benjamin Block <bblock@linux.ibm.com>, stable@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260912065526.833703348@linuxfoundation.org>
 <20260912065541.035531340@linuxfoundation.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260912065541.035531340@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178948388400.2895272.17739501733627014967@mxe9fb.netcup.net>
X-NC-CID: G07LcXNZHJgl8f/sUbBYM2wpv1Zo2eAH3ACT6gmR59KxmXIB1Mk=

On 9/12/26 09:00, Greg Kroah-Hartman wrote:
> 5.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Bart Van Assche <bvanassche@acm.org>
> 
> [ Upstream commit 92c4b58b15c56298b1b225c1d2e533165b3e32af ]
> 
> A quote from Documentation/driver-api/driver-model/device.rst:
> "Word of warning:  While the kernel allows device_create_file() and
> device_remove_file() to be called on a device at any time, userspace has
> strict expectations on when attributes get created.  When a new device is
> registered in the kernel, a uevent is generated to notify userspace (like
> udev) that a new device is available.  If attributes are added after the
> device is registered, then userspace won't get notified and userspace will
> not know about the new attributes."
> 
> Hence register SCSI host sysfs attributes before the SCSI host shost_dev
> uevent is emitted instead of after that event has been emitted.
> 
> Link: https://lore.kernel.org/r/20211012233558.4066756-2-bvanassche@acm.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Stable-dep-of: 225548863f0a ("scsi: smartpqi: Fix AIO retry marker cleared by SCSI core between dispatches.")

This 5.15.y change according to
https://bugzilla.kernel.org/show_bug.cgi?id=222016#c5 broke booting on
sata devices for two people; the second reporter indentified it to be
the culprit:

"""
I have a similar problem with 5.15.221, but in my case all the SATA hard
drives on 2 different units are gone. 'fdisk -l' shows only the
remaining NVMe device.
After some investigation, I stumbled over this commit here:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=694e1b6aabe4cd359b42c44b54c409c3147b6020
scsi: core: Register sysfs attributes earlier

This was the culprit on my 2 machines. After reverting this commit on
5.15.221 and recompiling the kernel, everything went back to normal.
"""

Ciao, Thorsten

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/scsi/hosts.c       | 23 ++++++++++-
>  drivers/scsi/scsi_priv.h   |  4 +-
>  drivers/scsi/scsi_sysfs.c  | 81 +++++++++++++++++++-------------------
>  include/scsi/scsi_device.h |  7 ++++
>  include/scsi/scsi_host.h   | 12 ++++++
>  5 files changed, 84 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index cf842c97639a7..b339c006cc35f 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -387,7 +387,7 @@ static struct device_type scsi_host_type = {
>  struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  {
>  	struct Scsi_Host *shost;
> -	int index;
> +	int index, i, j = 0;
>  
>  	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);
>  	if (!shost)
> @@ -492,7 +492,26 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  	shost->shost_dev.parent = &shost->shost_gendev;
>  	shost->shost_dev.class = &shost_class;
>  	dev_set_name(&shost->shost_dev, "host%d", shost->host_no);
> -	shost->shost_dev.groups = scsi_sysfs_shost_attr_groups;
> +	shost->shost_dev.groups = shost->shost_dev_attr_groups;
> +	shost->shost_dev_attr_groups[j++] = &scsi_shost_attr_group;
> +	if (sht->shost_attrs) {
> +		shost->lld_attr_group = (struct attribute_group){
> +			.attrs = scsi_convert_dev_attrs(&shost->shost_gendev,
> +							sht->shost_attrs)
> +		};
> +		if (shost->lld_attr_group.attrs)
> +			shost->shost_dev_attr_groups[j++] =
> +				&shost->lld_attr_group;
> +	}
> +	if (sht->shost_groups) {
> +		for (i = 0; sht->shost_groups[i] &&
> +			     j < ARRAY_SIZE(shost->shost_dev_attr_groups);
> +		     i++, j++) {
> +			shost->shost_dev_attr_groups[j] =
> +				sht->shost_groups[i];
> +		}
> +	}
> +	WARN_ON_ONCE(j >= ARRAY_SIZE(shost->shost_dev_attr_groups));
>  
>  	shost->ehandler = kthread_run(scsi_error_handler, shost,
>  			"scsi_eh_%d", shost->host_no);
> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> index b531dec3d4206..87c714b0bfba2 100644
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -138,13 +138,15 @@ extern int scsi_sysfs_add_sdev(struct scsi_device *);
>  extern int scsi_sysfs_add_host(struct Scsi_Host *);
>  extern int scsi_sysfs_register(void);
>  extern void scsi_sysfs_unregister(void);
> +struct attribute **scsi_convert_dev_attrs(struct device *dev,
> +					  struct device_attribute **dev_attr);
>  extern void scsi_sysfs_device_initialize(struct scsi_device *);
>  extern int scsi_sysfs_target_initialize(struct scsi_device *);
>  extern struct scsi_transport_template blank_transport_template;
>  extern void __scsi_remove_device(struct scsi_device *);
>  
>  extern struct bus_type scsi_bus_type;
> -extern const struct attribute_group *scsi_sysfs_shost_attr_groups[];
> +extern const struct attribute_group scsi_shost_attr_group;
>  
>  /* scsi_netlink.c */
>  #ifdef CONFIG_SCSI_NETLINK
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 7d3cbf4e6bc6e..2d7e394556c7e 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -424,15 +424,10 @@ static struct attribute *scsi_sysfs_shost_attrs[] = {
>  	NULL
>  };
>  
> -static struct attribute_group scsi_shost_attr_group = {
> +const struct attribute_group scsi_shost_attr_group = {
>  	.attrs =	scsi_sysfs_shost_attrs,
>  };
>  
> -const struct attribute_group *scsi_sysfs_shost_attr_groups[] = {
> -	&scsi_shost_attr_group,
> -	NULL
> -};
> -
>  static void scsi_device_cls_release(struct device *class_dev)
>  {
>  	struct scsi_device *sdev;
> @@ -1358,7 +1353,7 @@ static int scsi_target_add(struct scsi_target *starget)
>   **/
>  int scsi_sysfs_add_sdev(struct scsi_device *sdev)
>  {
> -	int error, i;
> +	int error;
>  	struct scsi_target *starget = sdev->sdev_target;
>  
>  	error = scsi_target_add(starget);
> @@ -1412,23 +1407,6 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
>  		}
>  	}
>  
> -	/* add additional host specific attributes */
> -	if (sdev->host->hostt->sdev_attrs) {
> -		for (i = 0; sdev->host->hostt->sdev_attrs[i]; i++) {
> -			error = device_create_file(&sdev->sdev_gendev,
> -					sdev->host->hostt->sdev_attrs[i]);
> -			if (error)
> -				return error;
> -		}
> -	}
> -
> -	if (sdev->host->hostt->sdev_groups) {
> -		error = sysfs_create_groups(&sdev->sdev_gendev.kobj,
> -				sdev->host->hostt->sdev_groups);
> -		if (error)
> -			return error;
> -	}
> -
>  	scsi_autopm_put_device(sdev);
>  	return error;
>  }
> @@ -1468,10 +1446,6 @@ void __scsi_remove_device(struct scsi_device *sdev)
>  		if (res != 0)
>  			return;
>  
> -		if (sdev->host->hostt->sdev_groups)
> -			sysfs_remove_groups(&sdev->sdev_gendev.kobj,
> -					sdev->host->hostt->sdev_groups);
> -
>  		if (IS_ENABLED(CONFIG_BLK_DEV_BSG) && sdev->bsg_dev)
>  			bsg_unregister_queue(sdev->bsg_dev);
>  		device_unregister(&sdev->sdev_dev);
> @@ -1611,23 +1585,31 @@ EXPORT_SYMBOL(scsi_register_interface);
>   **/
>  int scsi_sysfs_add_host(struct Scsi_Host *shost)
>  {
> -	int error, i;
> -
> -	/* add host specific attributes */
> -	if (shost->hostt->shost_attrs) {
> -		for (i = 0; shost->hostt->shost_attrs[i]; i++) {
> -			error = device_create_file(&shost->shost_dev,
> -					shost->hostt->shost_attrs[i]);
> -			if (error)
> -				return error;
> -		}
> -	}
> -
>  	transport_register_device(&shost->shost_gendev);
>  	transport_configure_device(&shost->shost_gendev);
>  	return 0;
>  }
>  
> +/*
> + * Convert an array of struct device_attribute pointers into an array of
> + * struct attribute pointers.
> + */
> +struct attribute **scsi_convert_dev_attrs(struct device *dev,
> +					  struct device_attribute **dev_attr)
> +{
> +	struct attribute **attrs;
> +	int i;
> +
> +	for (i = 0; dev_attr[i]; i++)
> +		;
> +	attrs = devm_kzalloc(dev, (i + 1) * sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return NULL;
> +	for (i = 0; dev_attr[i]; i++)
> +		attrs[i] = &dev_attr[i]->attr;
> +	return attrs;
> +}
> +
>  static struct device_type scsi_dev_type = {
>  	.name =		"scsi_device",
>  	.release =	scsi_device_dev_release,
> @@ -1636,8 +1618,10 @@ static struct device_type scsi_dev_type = {
>  
>  void scsi_sysfs_device_initialize(struct scsi_device *sdev)
>  {
> +	int i, j = 0;
>  	unsigned long flags;
>  	struct Scsi_Host *shost = sdev->host;
> +	struct scsi_host_template *hostt = shost->hostt;
>  	struct scsi_target  *starget = sdev->sdev_target;
>  
>  	device_initialize(&sdev->sdev_gendev);
> @@ -1645,6 +1629,23 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
>  	sdev->sdev_gendev.type = &scsi_dev_type;
>  	dev_set_name(&sdev->sdev_gendev, "%d:%d:%d:%llu",
>  		     sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
> +	sdev->gendev_attr_groups[j++] = &scsi_sdev_attr_group;
> +	if (hostt->sdev_attrs) {
> +		sdev->lld_attr_group = (struct attribute_group){
> +			.attrs = scsi_convert_dev_attrs(&sdev->sdev_gendev,
> +							hostt->sdev_attrs)
> +		};
> +		if (sdev->lld_attr_group.attrs)
> +			sdev->gendev_attr_groups[j++] = &sdev->lld_attr_group;
> +	}
> +	if (hostt->sdev_groups) {
> +		for (i = 0; hostt->sdev_groups[i] &&
> +			     j < ARRAY_SIZE(sdev->gendev_attr_groups);
> +		     i++, j++) {
> +			sdev->gendev_attr_groups[j] = hostt->sdev_groups[i];
> +		}
> +	}
> +	WARN_ON_ONCE(j >= ARRAY_SIZE(sdev->gendev_attr_groups));
>  
>  	device_initialize(&sdev->sdev_dev);
>  	sdev->sdev_dev.parent = get_device(&sdev->sdev_gendev);
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 3b3dbc37653da..d65cc2d577d8d 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -226,6 +226,13 @@ struct scsi_device {
>  
>  	struct device		sdev_gendev,
>  				sdev_dev;
> +	struct attribute_group	lld_attr_group;
> +	/*
> +	 * The array size 6 provides space for one attribute group for the
> +	 * SCSI core, four attribute groups defined by SCSI LLDs and one
> +	 * terminating NULL pointer.
> +	 */
> +	const struct attribute_group *gendev_attr_groups[6];
>  
>  	struct execute_work	ew; /* used to get process context on put */
>  	struct work_struct	requeue_work;
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 3ed93982dbf07..e4188b2a6bd79 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -483,6 +483,11 @@ struct scsi_host_template {
>  	 */
>  	struct device_attribute **sdev_attrs;
>  
> +	/*
> +	 * Pointer to the SCSI host sysfs attribute groups, NULL terminated.
> +	 */
> +	const struct attribute_group **shost_groups;
> +
>  	/*
>  	 * Pointer to the SCSI device attribute groups for this host,
>  	 * NULL terminated.
> @@ -698,6 +703,13 @@ struct Scsi_Host {
>  
>  	/* ldm bits */
>  	struct device		shost_gendev, shost_dev;
> +	struct attribute_group	lld_attr_group;
> +	/*
> +	 * The array size 3 provides space for one attribute group defined by
> +	 * the SCSI core, one attribute group defined by the SCSI LLD and one
> +	 * terminating NULL pointer.
> +	 */
> +	const struct attribute_group *shost_dev_attr_groups[3];
>  
>  	/*
>  	 * Points to the transport data (if any) which is allocated

#regzbot introduced: 694e1b6aabe4cd
#regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=222016
#regzbot title: partitions not recognized on sata devices
